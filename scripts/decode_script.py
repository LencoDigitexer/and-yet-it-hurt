import codecs, os
filename = "tmp.txt"
output = "tmp2.txt"

lst = os.listdir(path=".")

for i in range(0, len(lst)):
    try:
        print(lst[i])
        if lst[i] == "decode_script.py" or lst[i] == "decode_script.exe":
            continue
        filename = lst[i]
        output = lst[i]
    
        f = codecs.open(filename, 'r', 'utf-8')
        u = f.read()   # now the contents have been transformed to a Unicode string
        out = codecs.open(output, 'w', 'cp1251')
        out.write(u)   # and now the contents have been output as UTF-8
    except:
        print("Замечена папка или иной объект - пропускаем")