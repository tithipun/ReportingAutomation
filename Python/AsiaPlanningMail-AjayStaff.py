import datetime
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# -----------------------------
# RECIPIENTS
# -----------------------------
recipients = sorted([
    
    "adrian.mata@hanes.com",
    "ajay.godbole@hanes.com",
    "alejandra.huezo@hanes.com",
    "amanda.leftwich@hanes.com",
    "andrea.guerrapineda@hanes.com",
    "angelica.strothman@hanes.com",
    "armando.grisanti@hanes.com",
    "bessie.cordova@hanes.com",
    "carlos.vasquezdeleon@hanes.com",
    "chanin.chairiwjaroen@hanes.com",
    "chithalka.navaratna@hanes.com",
    "cindy.carter@hanes.com",
    "cindy.velasquez@hanes.com",
    "cuauhtemoc.herrera@hanes.com",
    "dan.gregory@hanes.com",
    "daniel.hardy@hanes.com",
    "darvin.delcid@hanes.com",
    "diego.romero@hanes.com",
    "efrain.peraza@hanes.com",
    "eugenia.lainez@hanes.com",
    "george.jennings@hanes.com",
    "ginger.hutchens@hanes.com",
    "girish.vishnubhotla@hanes.com",
    "guillermo.serna@hanes.com",
    "hali.swofford@hanes.com",
    "hemant.ramaswami@hanes.com",
    "imer.rivera@hanes.com",
    "james.francis@hanes.com",
    "jeff.badgett@hanes.com",
    "jeremy.jackson@hanes.com",
    "joe.atkins@hanes.com",
    "joy.greene@hanes.com",
    "juancarlos.silvestre@hanes.com",
    "justin.ross@hanes.com",
    "katerra.wiggins@hanes.com",
    "kelly.aleman@hanes.com",
    "kurt.fuehrer@hanes.com",
    "le.hoang@hanes.com",
    "lesley.garmon@hanes.com",
    "maria.soto1@hanes.com",
    "marino.rodriguez@hanes.com",
    "mark.twiddy@hanes.com",
    "matthew.gerber@hanes.com",
    "milagros.kelly@hanes.com",
    "naraporn.chainvirattanapit@hanes.com",
    "nelman.sabillon@hanes.com",
    "nicole.clarke@hanes.com",
    "nirca.pichardogarcia@hanes.com",
    "onidys.delossantos@hanes.com",
    "oscar.mayet@hanes.com",
    "perry.smith@hanes.com",
    "pitchanart.pladisai@hanes.com",
    "rachel.merrill@hanes.com",
    "randy.russell@hanes.com",
    "reynaldo.madridpineda@hanes.com",
    "ricardo.hidalgo@hanes.com",
    "ricardo.perez@hanes.com",
    "richard.shapiro@hanes.com",
    "rick.preston@hanes.com",
    "roberto.marincastro@hanes.com",
    "rodney.lyles@hanes.com",
    "rodolfo.delossantoslemus@hanes.com",
    "ron.mclemore@hanes.com",
    "seynebou.ndiaye@hanes.com",
    "sherri.jackson@hanes.com",
    "siroj.sathiensophon@hanes.com",
    "thomas.kim@hanes.com",
    "tithipun.bunjong@hanes.com",
    "vickie.vass@hanes.com",
    "victor.alvarez@hanes.com",
    "marion.greer@hanes.com",
    "maria.cruz7@hanes.com",
    "zoraya.gautier@hanes.com"

])

# -----------------------------
# SEND MAIL FUNCTION
# -----------------------------
def send_mail(recipients, subject, html_body):
    username = "AsiaPlanning@hanes.com"
    password = "v8vN9bjM99"  # ⚠️ Hardcoded as requested

    msg = MIMEMultipart()
    msg["From"] = username
    msg["To"] = ",".join(recipients)
    msg["Subject"] = subject
    msg.attach(MIMEText(html_body, "html"))

    try:
        print(f"Sending mail to {msg['To']} with subject '{subject}'...")
        mailServer = smtplib.SMTP("smtp-mail.outlook.com", 587)
        mailServer.ehlo()
        mailServer.starttls()
        mailServer.login(username, password)
        mailServer.send_message(msg)
        mailServer.quit()
        print("Finished sending email")
    except Exception as e:
        print("Error sending email:", str(e))

# -----------------------------
# EXPORT REPORT FUNCTION
# -----------------------------
def export_report():
    today = datetime.date.today()
    year, iso_week, _ = today.isocalendar()

    # ⚡ Use next week for planning
    report_week = iso_week + 1

    print(datetime.datetime.now())
    print("Start export report")
    print(f"ISO Week: {iso_week} | Report Week: {report_week}")

    subject = f"Ajay Staff Meeting Deck WK{report_week}"

    html_body = f"""
    <!DOCTYPE html>
    <html>
    <body style="font-size:14px;font-family:Verdana">

<p>Dear All,<br><br>
The Initial Ajay Staff Meeting Deck for WK{report_week} is posted.</p>

<p>Please use the link below to update</p>

<p>Remark<br>
The PPT file can be accessed via the link below</p>
<p>
          <a href="https://hanes.sharepoint.com/sites/operationsandproductionplanning/Operational%20Planning/Forms/AllItems.aspx?id=%2Fsites%2Foperationsandproductionplanning%2FOperational%20Planning%2FAjay%20Staff%20Meeting%20Deck%2FCY26&viewid=35a9ddf4%2De7da%2D4bb9%2Db96f%2De45c6165757d&clickparams=eyAiWC1BcHBOYW1lIiA6ICJNaWNyb3NvZnQgT3V0bG9vayIsICJYLUFwcFZlcnNpb24iIDogIjE2LjAuMTkzMjguMjAyNjYiLCAiT1MiIDogIldpbmRvd3MiIH0%3D&FolderCTID=0x012000E443BDD6EC8EC147887324107FBD92DB">
            PPT Files (sharepoint.com)
          </a>
        </p>

<!-- Highlighted, bold, underline ONLY for "New Re-Formatted Presentation Outline" -->
<p><span style="font-weight: bold; text-decoration: underline; background-color: yellow;">New Re-Formatted Presentation Outline</span></p>

<!-- Bold only for the section titles -->
<p><strong>Slide Section 1 - DC – quick update on month shipments / update on all DCs</strong></p>
<p><strong>Slide Section 2 - Logistics (In Bound flow, lead-times, delays, cost, contracts)</strong></p>
<p><strong>Slide Section 3 - Planning (The Fulfillment Leads = SLM, BI, TPD coverage views)</strong></p>

<!-- Indented items -->
<p style="margin-left:40px;">* Service Discussion
<p style="margin-left:40px;">* Demand and Safety Coverage

<p><strong>Slide Section 4 - Inventory</strong></p>
<p style="margin-left:40px;">* Finished Goods</p>
<p style="margin-left:40px;">* RM and WIP</p>

<p><strong>Slide Section 5 - Regional Update</strong></p>
<p style="margin-left:40px;">* Capacity (ASA)</p>
<p style="margin-left:40px;">* SE Result</p>
<p style="margin-left:40px;">* Mfg Lead-time</p>
<p style="margin-left:40px;">* Past Due</p>

<p><strong>Slide Section 6 - Forecasting</strong></p>
<p><strong>Slide Section 7 - PD</strong></p>
<p><strong>Slide Section 8 - Quality</strong></p>
<p><strong>Slide Section 9 - HR</strong></p>

<p>Thank you!<br>
Asia Planning</p>


        <br>

        <p>Link to SLM below</p>

        <p>
          <a href="https://hanes.sharepoint.com/sites/operationsandproductionplanning/Operational%20Planning/Forms/AllItems.aspx?viewpath=%2Fsites%2Foperationsandproductionplanning%2FOperational%20Planning%2FForms%2FAllItems%2Easpx">
          SLM (sharepoint.com)
          </a>
        </p>

        <p>If you would like to be added to the distribution list for <b>{subject}</b>, click below:</p>

        <p>
          <a href="mailto:tithipun.bunjong@hanes.com?subject=Add%20me%20to%20the%20mailing%20list%20for%20{subject.replace(' ', '%20')}">
          Add me to the mailing list
          </a>
        </p>
    </body>
    </html>
    """

    send_mail(recipients, subject, html_body)

# -----------------------------
# RUN SCRIPT
# -----------------------------
if __name__ == "__main__":
    export_report()
