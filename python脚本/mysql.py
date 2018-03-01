#function:	test.py
#describe:	loop reads  the  file under the FTP directory  and then 
#					store in to mysql database -->jailsystem
#author  : runfashi
#time    : 2018-1-26 15:54:39
#add	 : add runfashi： collec_area can input  chinese  2018-2-1 
#		 ：add runfashi：mysql login window  2018-2-5 


#!/usr/bin/python
# -*- coding: UTF-8 -*-
import platform
import re
import os,sys
import time
import pymysql
import tramform     # imsi 转手机号前七位
import sched   		# include timer
from tkinter import *
from tkinter import messagebox


path_dir="F:\data"+"\\"+"ftp"+"\\"	#文件夹目录
def gui_start():
	global init_window
	init_window=Tk()        #实例化出一个父窗口
	##设置窗口属性
	init_window.title("数据库的连接  by runfas")
	init_window.geometry('700x400+10+10')

	#建立标签
	#label=Label(init_window,font=("黑体", 18),text="数据库的连接",width=20, height=3)#设置标签字体的初始大小
	#label.pack(side=TOP)
	# welcome image
	canvas = Canvas(init_window, height=150, width=430)#创建画布
	canvas.pack(side=TOP)#放置画布（为上端）
	image_file = PhotoImage(file='F:\data\welcome.gif')#加载图片文件
	image = canvas.create_image(0,0, anchor='nw', image=image_file)#将图片置于画布上
	
	#建立输入框

	#mysql 地址
	labe_iddr = Label(init_window, text="mysql地址")
	labe_iddr.pack()  

	text_iddr_default = StringVar()	
	text_iddr = Entry(init_window, textvariable = text_iddr_default)
	text_iddr_default.set("localhost")
	text_iddr.pack()

	#账户
	labe_user = Label(init_window, text="账户")
	labe_user.pack()  

	text_user_default = StringVar()
	text_user = Entry(init_window, textvariable = text_user_default)
	text_user_default.set("root")
	text_user.pack()


	#密码
	labe_pwd = Label(init_window, text="密码")
	labe_pwd.pack()  

	text_pwd_default = StringVar()
	text_pwd = Entry(init_window, textvariable = text_pwd_default)
	text_pwd_default.set("root")
	text_pwd.pack()

	def inset_get():
		mysql_host = text_iddr.get()
		mysql_user = text_user.get()
		mysql_pwd  = text_pwd.get()
		print(mysql_host,mysql_user,mysql_pwd)
		try :
		#连接数据库
			global db_login
			#db_login=pymysql.connect(host="localhost",user="root",passwd="root",db="jailsystem",charset="utf8")
			db_login=pymysql.connect(host="%s"%mysql_host,user="%s"%mysql_user,passwd="%s"%mysql_pwd,db="jailsystem",charset="utf8")			
			init_window.destroy()
			main()	
		except:		
			print("ERROR:mysql not connect")
			messagebox.showinfo(title='login faild', message='登录失败，请重新登录 ')

	#建立按钮
	##通过command属性来指定Button的回调函数  
	button_sure = Button(init_window,text="确定",width=15,height=2,command=inset_get)
	button_sure.pack()
	init_window.mainloop()


def file_move(target_dir,source_dir):
	move_command = "move %s %s" %(source_dir,target_dir)
	if os.system(move_command)==0:	
		print("backup to %s success",target_dir)
	else :	
		print("backup to %s faild",target_dir)

############################################################
#主循环（读取文件--分析--存入数据库--关闭---备份文件---睡眠10s）
###########################################################

def main():
	while 1:
		dirs=os.listdir(path_dir)
		#print("dir num is %d"%len(dirs))
		if len(dirs)==0 : 
			print("There is no file in the directory")		
			time.sleep(10)
			continue
		#文件目录	
		file_dir = path_dir +dirs[0]
		#print(file_dir)
		fd = open(file_dir)
		txt = fd.read()
		#data analysis and store list
		list1=txt.split()
		list1_len = len(list1)
		n=0
		Acquisit_num = 6
		while list1_len>=Acquisit_num :	
			sn   		= list1[0+n]
			ipaddr   	= list1[1+n]
			time_ymd	= list1[2+n]
			time_hfs 	= list1[3+n] 		
			imsi        = list1[4+n]
			id  		= list1[5+n]
			collec_area = id[:len(id)-4]
			name 		= id[-4:]
			phone_7num  = tramform.imsi_transform(imsi)
			print("phone_7num :",phone_7num)
			print("7:",phone_7num[0:7] )
			#type: 0 is normal user  1 is illegal user
			#judge type
			type = 0
			se = db_login.cursor()
			se_type = "select phone_num from legalinfo WHERE  phone_num like '%s"%(phone_7num[0:7])  +"%'"
			#se_type = "select phone_num from legalinfo WHERE  phone_num like '1300102%'"
		
			print(se_type)
			try :
				se.execute(se_type)
				results = se.fetchall()
				print("results is :",results)
				if(len(results) ==0) : print("There is no matching imsi legally")
				for x in results :							
					if x[0][0:7] == phone_7num[0:7] :
						type = 1
						print("It is legal phone number ")
					else :
						type = 0
						print("There is no matching imsi legally")
			except:
	   				print("match error ")
	   				
	   	  		
			#mysql operator
			#create a object  of cursor 
			list1_len = list1_len-Acquisit_num
			n=n+Acquisit_num
			cursor = db_login.cursor()
			in_device="INSERT INTO deviceinfo(name,sn,ipaddr,lastonline) VALUES('%s','%s','%s','%s %s')" % (name,sn,ipaddr,time_ymd,time_hfs)
			in_imsi = "INSERT INTO imsiinfo(imsi,phone_num,time,collec_area,type) VALUES('%s','%s','%s %s','%s',%d)" % (imsi,phone_7num[0:7],time_ymd,time_hfs,collec_area,type)
			
			#print(in_imsi)
			try :
				cursor.execute(in_device)
				db_login.commit()
			except:
	   			print("Error: infer deviceinfo faild")
			try :
				cursor.execute(in_imsi)
				db_login.commit()
			except:
	   			print("Error: infer imsiinfo faild")
		fd.close()
		print("close OK")
	#######################################################	
	#文件拷贝部分：
	#######################################################
		target_dir = "f:\data_backup\\"+dirs[0]	#拷贝目录
		source_dir = file_dir
		file_move(target_dir,source_dir)
	######################################################
	#关闭数据库  睡眠10s 然后继续循环
	######################################################
		time.sleep(10)
		
	else :
		db_login.close()
		print("Good Bye ")




##################################################################################


##################################################################################

#login_dir = os.path.dirname(__file__)  #返回当前文件所在的目录  
# 如果不需要界面 可以直接注释这个函数、
# 并替换下面 数据库连接 db_login=pymysql.connect(host="localhost",user="root",passwd="root",db_login="jailsystem",charset="utf8")
gui_start()
