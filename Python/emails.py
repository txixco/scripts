import win32com.client

outlook = win32com.client.Dispatch("Outlook.Application").GetNamespace("MAPI")
inbox = outlook.Folders["fjrueda@west.com"].Folders["Inbox"]

def get_recipients_str(recipients):
    return "; ".join(recip.Name for recip in recipients)

def get_email_address():
    for message in inbox.Items:
        print("========")
        print("Subj: " + message.Subject)
        print('To:', get_recipients_str(message.Recipients))    #this part does not work
        print("Email Type: ", message.SenderEmailType)
        if message.Class == 43:
            try:
                if message.SenderEmailType == "SMTP":
                    print("Name: ", message.SenderName)
                    print("Email Address: ", message.SenderEmailAddress)
                    print('To:', get_recipients_str(message.Recipients))    #this part does not work
                    print("Date: ", message.ReceivedTime)
                elif message.SenderEmailType == "EX":
                    print("Name: ", message.SenderName)
                    print("Email Address: ", message.Sender.GetExchangeUser(
                                                              ).PrimarySmtpAddress)
                    print('To:', message.Recipients)    #this part does not work
                    print("Date: ", message.ReceivedTime)
            except Exception as e:
                print(e)
                continue


if __name__ == '__main__':
    get_email_address()