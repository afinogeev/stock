#!/usr/bin/python3
# -*- coding: utf-8 -*-

from bs4 import BeautifulSoup
import requests as req

import time
from selenium import webdriver

import pandas as pd
import json


def getRating():
    resp = req.get('https://www.dohod.ru/ik/analytics/share')
    soup = BeautifulSoup(resp.text, 'lxml')
    table = soup.find_all(id='table-stock-share')[0]

    table = soup.find_all('table')[0].tbody

    data = {}
    for tr in table.find_all('tr'):
        tds = tr.find_all('td')
        name = tds[1].text[:-8]
        sector = tds[2].text
        ticker = tds[24].text.split('.')[0]
        rating = int(tds[4].text.strip())
        market = int(tds[1].text[-1:])
        if market == 1:
            data[ticker] = {'name':name, 'sector':sector, 'rating':rating, 'graph':'', 'fundamental':''}
    return data
            
def getTech():
    options = webdriver.ChromeOptions()
    chrome_prefs = {}
    options.experimental_options["prefs"] = chrome_prefs
    chrome_prefs["profile.default_content_settings"] = {"images": 2}
    chrome_prefs["profile.managed_default_content_settings"] = {"images": 2}
    options.headless = True
    options.add_argument("--headless")
    options.add_argument('--no-sandbox')

    driver = webdriver.Chrome(options=options)   
    driver.get('https://ru.investing.com/equities/russia')
    driver.find_element_by_xpath('//*[@id="all"]').click()
    print('waiting data')
    time.sleep(5)
    driver.find_element_by_xpath('//*[@id="filter_technical"]').click()
    for i in range(1,11):
        try:
            print(f'try {i} load technical data')
            time.sleep(5)
            tbl = driver.find_element_by_xpath('//*[@id="marketsTechnical"]').get_attribute('outerHTML')
            break
        except:
            print('cannot load technical data')
            if i == 10: return
    df  = pd.read_html(tbl)[0]
    driver.close()
    
    datalist = df.values.tolist()

    datadict = {}
    for d in datalist:
        for i in range(2,len(d)):
            s = str(d[i])
            s = s.lower()
            # print(s)
            if s.find('продавать') > -1:
                d[i] = -1
            if s.find('покупать') > -1:
                d[i] = 1
            if s.find('нейтрально') > -1:
                d[i] = 0
        datadict[d[1]] = d[3] + d[4] + d[5]       
    return datadict

def compileData(rdata, tdata):
    iNames = {}
    with open('iNames.json') as json_file:
        iNames = json.load(json_file)
    datalist = []
    slKeyG = ''
    slKeyF = ''
    keys = list(rdata.keys())
    for key in keys:
        ###uppering###
        parts = key.split('_')
        if len(parts) > 1:
            key = parts[0].upper() + '_p'
            slKeyG = parts[0].upper() + 'P'
            slKeyF = parts[0].upper()
        else:
            key = key.upper()
            if key[-2:] == 'DR':
                slKeyG = key[:-2]
                slKeyF = key[:-2]
            else:
                slKeyG = key
                slKeyF = key
        ##############
        try:
            rdata[key]['name'] = iNames[key]
            rdata[key]['ticker'] = key
            rdata[key]['tech'] = tdata[iNames[key]]
            rdata[key]['tech'] = tdata[iNames[key]]
            rdata[key]['graph'] = f'https://smart-lab.ru/gr/MOEX.{slKeyG}'
            rdata[key]['fundamental'] = f'https://smart-lab.ru/q/{slKeyF}/f/y/'
            datalist.append(rdata[key])
        except:
            print(f'{key} ticker doesn-t exist')
    return datalist

print('getting rating')
try:
    ratingData = getRating()
except Exception as e:
    print('cannot get rating data')
    exit()  
print('done')   
print('getting technical')
try:
    techData = getTech()
except Exception as e:
    print('cannot get technical data')
    exit()  
print('done')
print('compiling data')
try:
    data = compileData(ratingData, techData)
except Exception as e:
    print('cannot compile data')
    exit() 
print('done')

print('saving to json-file')
filename = 'result.json'
with open(filename, 'w') as outfile:
    json.dump(data, outfile)
    
print('all done')