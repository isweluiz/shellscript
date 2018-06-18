# json

Hello everybody, my name's Luiz I'm a student's data science, I'm a curious whith computer, in this page I will go shared some codes in json, in special some codes for controller the api's zabbix and extract data. I work in a project what would like extract information about hosts in zabbix and to integrate in qlikview...  From here time I will go post the result. Good Luck! 

 ---
 
 #### 1ª Steps 
 
 ##### Alternatives for execute json 
 First alternative
 
 For execute the codes json in command line in linux you've utilize the **curl**, somes exemple: 
 ```sh
$ curl -X POST -H 'Content-Type:application/json' --data @apiinfo.version.json http://zabbix.test.br/zabbix/api_jsonrpc.json  | python -mjson.tool
```

Second alternative 

Utilize my script in command line
````sh
[root@isweluiz apiinfo.version]# ./fatilizken.sh apiinfo.version.json
{
    "id": 1,
    "jsonrpc": "2.0",
    "result": "3.2.3"
}
````

For more alternatives 
 **Contacte me** 

-My linkedin [Linkedin](https://www.linkedin.com/in/isweluiz/)


 
