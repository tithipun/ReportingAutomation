# Testing Git

import os
import sys
import datetime
import smtplib
import socket
import time
import logging

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

import win32com.client
from PIL import ImageGrab


# Logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
log = logging.getLogger(__name__)


# ---------- FUNCTION 0: GET LATEST EXCEL FILE ----------
def get_latest_excel(folder_dir):
    """
    Finds the most recently modified Excel file starting with
    'AIPS Compliance Report' in folder_dir and returns its path.
    """
    prefix = "AIPS Compliance Report"

    try:
        files = os.listdir(folder_dir)
    except OSError as e:
        raise FileNotFoundError(f"Cannot list folder {folder_dir}: {e}") from e

    candidates = [os.path.join(folder_dir, f) for f in files if f.startswith(prefix) and f.lower().endswith(".xlsx")]
    if not candidates:
        raise FileNotFoundError(f"No Excel file found starting with: {prefix} in {folder_dir}")

    try:
        latest_file = max(candidates, key=os.path.getmtime)
    except OSError as e:
        raise RuntimeError(f"Failed to determine newest file in {folder_dir}: {e}") from e

    log.info("Using latest Excel file: %s", latest_file)
    return latest_file


# ---------- FUNCTION 1: CAPTURE EXCEL RANGE TO IMAGE ----------
def excel_to_img(excel_path, img_path, sheet, r1, c1, r2, c2):
    """
    Captures a range from Excel and saves it as an image.
    """
    excel = None
    wb = None
    try:
        excel = win32com.client.DispatchEx("Excel.Application")
        excel.Visible = False
        excel.DisplayAlerts = False
        wb = excel.Workbooks.Open(excel_path)

        try:
            ws = wb.Worksheets(sheet)
        except Exception as e:
            raise ValueError(f"Worksheet '{sheet}' not found in {excel_path}") from e

        rng = ws.Range(ws.Cells(r1, c1), ws.Cells(r2, c2))
        rng.CopyPicture(Appearance=1, Format=2)

        time.sleep(0.5)

        img = None
        attempts = 3
        for i in range(attempts):
            img = ImageGrab.grabclipboard()
            if img is not None:
                break
            time.sleep(0.5)

        if img is None:
            raise RuntimeError("Failed to grab image from clipboard after retries")

        img.save(img_path)

    finally:
        if wb is not None:
            try:
                wb.Close(False)
            except Exception:
                log.exception("Failed to close workbook")
        if excel is not None:
            try:
                excel.Quit()
            except Exception:
                log.exception("Failed to quit Excel")


# ---------- FUNCTION 2: SEND EMAIL WITH INLINE IMAGE ----------
def send_mail(subject, week, img_path, folder_yyyyww):
    username = os.environ.get("AIPS_EMAIL_USER", "AsiaPlanning@hanes.com")
    password = os.environ.get("AIPS_EMAIL_PASS")
    if not password:
        raise RuntimeError("Missing AIPS_EMAIL_PASS environment variable")

    html = f"""
    <!DOCTYPE html>
    <html>
    <body style="font-size:12px;font-family:Verdana">

    <p>Dear All,</p>
    <p>Kindly see AIPS Compliance Week {week} below:</p>

    <br>
    <div><img src="cid:image1"></div>
    <br>

    <p>Thank you!<br>Asia Planning</p>

    <p>Detail file can be accessed below:</p>
    <p>
        <a href="file://///hanes-vdi0008/Share_data/AIPS%20Compliant%20Report/{folder_yyyyww}">
            \\\\hanes-vdi0008\\Share_data\\AIPS Compliant Report\\{folder_yyyyww}
        </a>
    </p>

    </body>
    </html>
    """

    # ---- DS / DISTRIBUTION LIST ----
    address_book = [
        "Chanin.Chairiwjaroen@hanes.com",
        "Chanwit.Chakonsatian@hanes.com",
        "Dilum.Abewickrama@hanes.com",
        "Girish.Vishnubhotla@hanes.com",
        "Le.Hoang@hanes.com",
        "PhuongHa.ThiTran@hanes.com",
        "Sirapatch.Boonyong@hanes.com",
        "Siroj.Sathiensophon@hanes.com",
        "Tithipun.Bunjong@hanes.com",
        "Worawan.Rattananaikomol@hanes.com",
        "kiet.nguyen15@hanes.com",
        "ngoi.mai1@hanes.com",
        "Ha.Doan@hanes.com",
        "Hue.Nguyen5@hanes.com",
        "ThiThuHuong.Bui@hanes.com",
        "tuan.hoang@hanes.com",
        "Phuong.Le2@hanes.com",
        "Linh.Le9@hanes.com",
        "HuyMung.Nguyen@hanes.com",
    ]

    msg = MIMEMultipart("related")
    msg["From"] = username
    msg["To"] = ",".join(address_book)
    msg["Subject"] = subject
    msg.attach(MIMEText(html, "html"))

    with open(img_path, "rb") as f:
        mime = MIMEBase("image", "png")
        mime.set_payload(f.read())
        encoders.encode_base64(mime)
        mime.add_header("Content-ID", "<image1>")
        msg.attach(mime)

    smtp_host = "smtp-mail.outlook.com"
    smtp_port = 587

    attempts = 3
    backoff = 1.0
    for attempt in range(1, attempts + 1):
        try:
            with smtplib.SMTP(smtp_host, smtp_port, timeout=30) as server:
                server.ehlo()
                server.starttls()
                server.login(username, password)
                server.send_message(msg)
            log.info("Email sent successfully")
            return
        except (smtplib.SMTPException, socket.timeout, ConnectionRefusedError) as exc:
            log.exception("Attempt %s: failed to send email: %s", attempt, exc)
            if attempt == attempts:
                raise
            time.sleep(backoff)
            backoff *= 2


# ---------- MAIN FUNCTION ----------
def export_report():
    today = datetime.date.today()
    print(datetime.datetime.now())
    print("Start export report")

    # ---- PREVIOUS WEEK ----
    last_week_date = today - datetime.timedelta(weeks=1)
    last_year, last_week, _ = last_week_date.isocalendar()
    current_week = today.strftime("%V")

    # ---- YYYYWW FOLDER ----
    folder_yyyyww = f"{last_year}{last_week:02d}"
    print(f"Current week: {current_week}")
    print(f"Using previous week folder: {folder_yyyyww}")

    # ---- BASE FOLDER (NETWORK) ----
    base_dir = rf"\\hanes-vdi0008\Share_data\AIPS Compliant Report\{folder_yyyyww}"
    if not os.path.exists(base_dir):
        raise FileNotFoundError(f"Folder not found:\n{base_dir}")

    # ---- GET LATEST EXCEL FILE ----
    excel_file = get_latest_excel(base_dir)

    # ---- IMAGE OUTPUT (TEMP) ----
    img_path = os.path.join(
        os.environ["TEMP"],
        f"AIPS_Compliance_WK{last_week:02d}.png"
    )

    print(f"Excel file: {excel_file}")
    print(f"Image file: {img_path}")

    # ---- CAPTURE EXCEL RANGE ----
    excel_to_img(
        excel_file,
        img_path,
        sheet="AIPS Compliance",
        r1=1, c1=1,
        r2=60, c2=16
    )

    print("Created Excel image")

    # ---- SEND EMAIL ----
    send_mail(
        subject=f"AIPS Compliance Week {current_week}",
        week=current_week,
        img_path=img_path,
        folder_yyyyww=folder_yyyyww
    )


# ---------- RUN ----------
if __name__ == "__main__":
    export_report()
