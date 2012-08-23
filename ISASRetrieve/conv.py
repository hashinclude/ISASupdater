from BeautifulSoup import BeautifulSoup

page=open("new").read()
soup=BeautifulSoup(page)
txt=soup.findAll(text=True)

for i in range(len(txt)):
	if(txt[i]=='\n'):
		txt[i]=''		
	else:
		break
for i in range(len(txt)-1,0,-1):
	if(txt[i]=='\n'):
		txt[i]=''		
	else:
		break

out=""
cnt=0
for i in range(24,len(txt)):
	if(len(txt[i])>4):
		if(txt[i][0]=='2' and txt[i][1]=='0'):
			out+='\n\n'

	out+=txt[i]
	out+=" " 
	if(txt[i]=="PCO/Normal"):
		out+="\n  "
	if(len(txt[i])>4):
		if(txt[i][0]=='2' and txt[i][1]=='0'):
			out+='\n'
	if(txt[i]=="Course Code"):
		txt[i+1]=""
	if(len(txt[i].split())==2):
		x=txt[i].split()[1]
		if(x=="Known"):
			cnt+=1
			if(cnt==2):
				out+="\n\n\n"
	if(len(txt[i].split())>0):
		txt[i]=txt[i].split()[0]
	if(txt[i]=='1' or txt[i]=='2' or txt[i]=='3' or txt[i]=='4' or txt[i]=='5'):
		txt[i+1]=""
	if(txt[i]=='N' or txt[i]=='P'):
		out+="\n  "
print out
