import json, requests

try:

    r = requests.get('https://ipapi.co/json')
    r.raise_for_status()
    data=r.json()

    ip=data['ip']
    print ("ip :",ip)

    loc = {}
    key1=["city","region","country_name","timezone"]

    for key in key1:
        if key in data:
            loc[key]= data[key]
        elif key not in data:
             raise Exception(key,": key not found in", data)

    for key, value in loc.items():
        print(key,":", value)

except requests.exceptions.HTTPError as err:
        raise SystemExit(err)