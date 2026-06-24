import sys
import os

import  numpy  as  np 
import pandas as pd

#import random
import datetime
from datetime import date, timedelta
import time
import schedule
import openpyxl
import smtplib,email,email.encoders,email.mime.text
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import xlwings as xw

cwd = os.getcwd()

def send_mail(recipient, subject, message, week,path_attached):
    username = "AsiaPlanning@hanes.com"
    password = "v8vN9bjM99"
    html = '<!DOCTYPE html>'
    html +='<html>'
    html +='<body style="font-size:12px;font-family:Verdana"><p>Dear All,<br><br> Initial Monthly KIR Deck is posted expecting all updates will be ready be end of the week</p>'
    html +='<p>Thank! <br>Asia Planning</p> <br>'
    html +='<p>Remark <br>PPT file is located below link</p>'
    html +='<p><div><a href="https://hanes.sharepoint.com/sites/operationsandproductionplanning/Operational%20Planning/Forms/AllItems.aspx?viewpath=%2Fsites%2Foperationsandproductionplanning%2FOperational%20Planning%2FForms%2FAllItems%2Easpx&id=%2Fsites%2Foperationsandproductionplanning%2FOperational%20Planning%2FAjay%20KIR%20Meeting%20Deck&viewid=35a9ddf4%2De7da%2D4bb9%2Db96f%2De45c6165757d%22%3E%20PPT%20Files%20(sharepoint.com)%3C/a%3E%3C/div%3E%3C/p%3E%20%3Cbr%3Ehttps://hanes.sharepoint.com/sites/operationsandproductionplanning/Operational%20Planning/Forms/AllItems.aspx?viewpath=%2Fsites%2Foperationsandproductionplanning%2FOperational%20Planning%2FForms%2FAllItems%2Easpx&id=%2Fsites%2Foperationsandproductionplanning%2FOperational%20Planning%2FAjay%20KIR%20Meeting%20Deck&viewid=35a9ddf4%2De7da%2D4bb9%2Db96f%2De45c6165757d%22%3E%20PPT%20Files%20(sharepoint.com)%3C/a%3E%3C/div%3E%3C/p%3E%20%3Cbr%3E"> PPT Files (sharepoint.com)</a></div></p> <br>'
    html += f'<p>If you would like to be added to the distribution list for <b>{subject}</b>, click below:</p>'
    html += f'<p><a href="mailto:tithipun.bunjong@hanes.com?subject=Add%20me%20to%20the%20mailing%20list%20for%20{subject.replace(" ", "%20")}">Add me to the mailing list</a></p>'
    html += "</body></html>"
    
    address_book = ["tithipun.bunjong@hanes.com","Ajay.Godbole@hanes.com","Ginger.Hutchens@hanes.com","Mark.Twiddy@hanes.com","James.Francis@hanes.com","Kurt.Fuehrer@hanes.com","Justin.Ross@hanes.com","George.Jennings@hanes.com"]
    address_cc = ["bessie.cordova@hanes.com","maria.cruz7@hanes.com","kerinalexis.gonzalezdiaz6@hanes.com","virna.schery@hanes.com","hemant.ramaswami@hanes.com","Le.Hoang@hanes.com","Pitchanart.Pladisai@hanes.com","Diego.Romero@hanes.com","Roy.Coello@hanes.com","Zoraya.Gautier@hanes.com","Nelman.Sabillon@hanes.com","Carlos.VasquezDeLeon@hanes.com","Onidys.DeLosSantos@hanes.com","Judy.Foy@hanes.com","ricardo.hidalgo@hanes.com","Nirca.PichardoGarcia@hanes.com","Kelly.Aleman@hanes.com","Vickie.Vass@hanes.com","cindy.velasquez@hanes.com","rodney.lyles@hanes.com"]
    
    msg = MIMEMultipart()
    msg['From'] = username
    msg['To'] = ','.join(address_book)
    msg['Cc'] = ','.join(address_cc)
    msg['Subject'] = subject
    msg.attach(MIMEText(html,'html'))
    # now attach the file
    # part = MIMEBase('application', "octet-stream")
    # part.set_payload(open(path_attached, "rb").read())
    # encoders.encode_base64(part)
    # part.add_header('Content-Disposition', 'attachment; filename="BaoCaoTemChuaScan_'+date_export+'.xlsb"')
    # msg.attach(part)
 
    try:
        # print('sending mail to ' + recipient + ' on ' + subject)

        mailServer = smtplib.SMTP('smtp-mail.outlook.com', 587)
        mailServer.ehlo()
        mailServer.starttls()
        mailServer.ehlo()
        mailServer.login(username, password)
        mailServer.send_message(msg)
        # mailServer.sendmail(username, recipient, msg.as_string())
        mailServer.close()

    except error as e:
        print(str(e))
    print('finished send email')




def export_report():

    d_end=datetime.date.today() - datetime.timedelta(days=15)

    print(datetime.datetime.now())
    print('start export report')

    month=d_end.strftime('%b')
    # write data to fomr
    
    send_mail('', 'Monthly KIR Deck - End '+month, 'body',month,any)
    #send_mail(recipient, subject, message, date_export,path_attached,img,img2)

export_report()

