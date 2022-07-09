import json
import urllib

def create_header(headermeta):
#TODO: create header_dict from headermeta
    header_dict = {}
    for name in headermeta:
        header_dict[name['name'].replace(':', '')] = name['value']
    return header_dict


metadict = {"filename":r"hd.har", "filetoken":r"VIDNAMEHERE"}
dat = json.loads(open(rf"C:\Users\phana\Downloads\{metadict['filename']}", 'rb').read())
url_list = []
for item in dat['log']['entries']: 
    headermeta = item['request']['headers']
    headerdict = create_header(headermeta)
    url = item['request']['url']
    if url.find(metadict["filetoken"]) >= 0:
        url_list.append({"url":url, "headers": headerdict})

filename_list = []
for idx, item in enumerate(url_list):
    filename = f"file{idx}.ts"
    filename_list.append("file " + filename)
    url = item['url']
    headers = item['headers']    
    req = urllib.request.Request(url=url, headers=headers)
    page = urllib.request.urlopen(req).read()
    open(filename, 'wb').write(page)
open("filelist.txt", "w").write('\n'.join(filename_list[1:]))    
    
#use this command to convert .ts to mp4
#ffmpeg -i file1.ts -c:v libx264 -c:a copy output.mp4
#ffmpeg -f concat   -i filelist.txt  -c:v libx264 -c:a copy hdsr4.ts
