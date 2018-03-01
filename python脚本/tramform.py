###############################
#author： shirunfa+
#time：   2018-2-5 
#des：	  imsi 转 手机号码前七位
#add ：   
##################################
#!/usr/bin/python
# -*- coding: UTF-8 -*-



import platform
import re
import os

global phone_num
phone_num = ['0','0','0','0','0','0','0','0','0','0','0']

def imsi_transform(imsi_num):
	phone_num = ['0','0','0','0','0','0','0','0','0','0','0']
	if len(imsi_num) != 15 : 
		print("imput imsi is  error ")
		return ;
	#判断是否为联通
	elif imsi_num[4] == "1"  or imsi_num[4] =="6" :
		if imsi_num[9] == "0" or imsi_num == "1":
			phone_num[0] = "1"
			phone_num[1] = "3"
			phone_num[2] = "0"
		if imsi_num[9] == "2" :
			phone_num[0] = "1"
			phone_num[1] = "3"
			phone_num[2] = "2"	
		if imsi_num[9] == "3" :
			phone_num[0] = "1"
			phone_num[1] = "5"
			phone_num[2] = "6"	
		if imsi_num[9] == "4" :
			phone_num[0] = "1"
			phone_num[1] = "5"
			phone_num[2] = "5"	
		if imsi_num[9] == "6" :
			phone_num[0] = "1"
			phone_num[1] = "8"
			phone_num[2] = "6"	
		if imsi_num[9] == "9" :
			phone_num[0] = "1"
			phone_num[1] = "3"
			phone_num[2] = "1"	
		#phone_num[3:6] = imsi_num[8] + imsi_num[5] + imsi_num[6] +imsi_num[7]
		
		phone_num[3] = imsi_num[8]
		phone_num[4] = imsi_num[5]
		phone_num[5] = imsi_num[6]
		phone_num[6] = imsi_num[7]		
		print("Uncicom operator phone num :",phone_num)
		phone="".join(phone_num)
		return phone 
	#判断是否为移动
	elif imsi_num[4] == "0" or imsi_num[4] == "2" or imsi_num[4] == "7" :
		if imsi_num[4] == "0":
			if int(imsi_num[8])>=5 and int(imsi_num[8])<=9 :
				phone_num[0] = "1"
				phone_num[1] = "3"
				phone_num[2] = imsi_num[8]
				phone_num[3] = "0"
				phone_num[4] = imsi_num[5]
				phone_num[5] = imsi_num[6]
				phone_num[6] = imsi_num[7]
			else :
				phone_num[0] = "1" 
				phone_num[1] = "3"
				phone_num[2] = imsi_num[8]
				phone_num[3] = imsi_num[9]
				phone_num[4] = imsi_num[5]
				phone_num[5] = imsi_num[6]
				phone_num[6] = imsi_num[7]

		if imsi_num[4] == "2" :
			phone_num[3] = imsi_num[6]
			phone_num[4] = imsi_num[7]
			phone_num[5] = imsi_num[8]
			phone_num[6] = imsi_num[9]

			if imsi_num[5] == "0" :
				phone_num[0] = "1"
				phone_num[1] = "3"
				phone_num[2] = "4"
			if imsi_num[5] == "1" :
				phone_num[0] = "1"
				phone_num[1] = "5"
				phone_num[2] = "1"
			if imsi_num[5] == "2" :
				phone_num[0] = "1"
				phone_num[1] = "5"
				phone_num[2] = "2"
			if imsi_num[5] == "3" :
				phone_num[0] = "1"
				phone_num[1] = "5"
				phone_num[2] = "0"
			if imsi_num[5] == "7" :
				phone_num[0] = "1"
				phone_num[1] = "8"
				phone_num[2] = "7"
			if imsi_num[5] == "8" :
				phone_num[0] = "1"
				phone_num[1] = "5"
				phone_num[2] = "8"
			if imsi_num[5] == "9" :
				phone_num[0] = "1"
				phone_num[1] = "5"
				phone_num[2] = "9"

		if imsi_num[4] == "7" :
			phone_num[3] = imsi_num[6]
			phone_num[3] = imsi_num[7]
			phone_num[5] = imsi_num[8]
			phone_num[6] = imsi_num[9]
			if imsi_num[5] == "7" :
				phone_num[0] = "1"
				phone_num[1] = "5"
				phone_num[2] = "7"
			if imsi_num[5] == "8" :
				phone_num[0] = "1"
				phone_num[1] = "8"
				phone_num[2] = "8"
			if imsi_num[5] == "9" :
				phone_num[0] = "1"
				phone_num[1] = "4"
				phone_num[2] = "7"
		print("Mobie operator phone num :",phone_num)
		phone="".join(phone_num) 
		return phone 
	#其他用户
	else :
		print("Other operator  phone num :",phone_num)
		phone="".join(phone_num) 
		return phone 

