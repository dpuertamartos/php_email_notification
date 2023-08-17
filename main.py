import subprocess
import smtplib
from decouple import config

# Read variables from .env file
php_localization = config('PHP_LOCALIZATION')
php_script = config('PHP_SCRIPT')
log_file = config('LOG_FILE')
recipient = config('RECIPIENT')
gmail_user = config('GMAIL_USER')
gmail_app_password = config('GMAIL_APP_PASSWORD')

print(php_localization)
#standard output Out of host capacity
expected_output = '{"code": "InternalError", "message": "Out of host capacity."}'


def send_email(to, subject, body, gmail_user, gmail_password):

    sent_from = gmail_user

    email_text = """\
    From: %s
    To: %s
    Subject: %s

    %s
    """ % (sent_from, ", ".join(to), subject, body)

    try:
        server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
        server.ehlo()
        server.login(gmail_user, gmail_password)
        server.sendmail(sent_from, to, email_text)
        server.close()

        print('Email sent!')
    except:
        print('Something went wrong...')


# Execute PHP script and capture output
output = subprocess.getoutput(f"{php_localization} {php_script}")

# Append output to log file
with open(log_file, "a") as f:
    f.write(output + "\n")

# Check if output matches expected output
if expected_output not in output:
    # Send an email if output does not match
    send_email(to=[recipient],
               subject='Notification - PHP script to create oracle cloud VM',
               body=f"The script output does not match the expected output.\n{output}",
               gmail_user=gmail_user,
               gmail_password=gmail_app_password,
               )

