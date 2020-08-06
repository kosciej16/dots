telnet imap.gmail.com 143
nc --crlf --verbose imap.gmail.com 143

with ssl
openssl s_client -connect imap.gmail.com:993 -crlf -quiet

and tsl?
openssl s_client -connect imap.gmail.com:993 -crlf -quiet -starttls


<tag> + command
login someuser@example.atmailcloud.com My_P@ssword1
namespace
list / *
select INBOX
fetch 1:4 (BODY[HEADER.FIELDS (Subject)])
search UNSEEN
fetch 2 RFC822
store 2 +FLAGS (Deleted)
expunge
