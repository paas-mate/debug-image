# ROOT CA
openssl genrsa -out root-ca1.key 2048
openssl req -x509 -new -extensions v3_ca -key root-ca1.key -days 3650 -out root-ca1.pem \
-subj '/C=AA/ST=AA/L=AA/O=AA Ltd/OU=AA/CN=*.ca1.com/emailAddress=ca1@gmail.com'
# INTER CA
openssl genrsa -out sec-ca1.key 2048
openssl req -new -extensions v3_ca -key sec-ca1.key -out sec-ca1.csr \
-subj '/C=BB/ST=BB/L=BB/O=BB Ltd/OU=BB/CN=*.sec-ca1.com/emailAddress=*.sec-ca1.com'
openssl x509 -req -extfile /opt/sh/config/root-ca1.conf -extensions v3_ca -days 365 -CA root-ca1.pem -CAkey root-ca1.key \
-CAcreateserial -in sec-ca1.csr -out sec-ca1.pem
# SERVER CA
openssl genrsa -out server1.key 2048
openssl req -new -key server1.key -out server1.csr \
-subj '/C=CC/ST=CC/L=CC/O=CC Ltd/OU=CC/CN=*.server1.com/emailAddress=*.server1.com'
openssl x509 -req -extensions usr_cert -days 365 -CA sec-ca1.pem -CAkey sec-ca1.key \
-CAcreateserial -in server1.csr -out server1.pem

cat server1.pem >> server1-all.pem
cat sec-ca1.pem >> server1-all.pem
cat root-ca1.pem >> server1-all.pem

# ROOT CA
openssl genrsa -out root-ca2.key 2048
openssl req -x509 -new -extensions v3_ca -key root-ca2.key -days 3650 -out root-ca2.pem \
-subj '/C=AA/ST=AA/L=AA/O=AA Ltd/OU=AA/CN=*.ca2.com/emailAddress=ca2@gmail.com'
# INTER CA
openssl genrsa -out sec-ca2.key 2048
openssl req -new -extensions v3_ca -key sec-ca2.key -out sec-ca2.csr \
-subj '/C=BB/ST=BB/L=BB/O=BB Ltd/OU=BB/CN=*.sec-ca2.com/emailAddress=*.sec-ca2.com'
openssl x509 -req -extfile /opt/sh/config/root-ca2.conf -extensions v3_ca -days 365 -CA root-ca2.pem -CAkey root-ca2.key \
-CAcreateserial -in sec-ca2.csr -out sec-ca2.pem
# SERVER CA
openssl genrsa -out client2.key 2048
openssl req -new -key client2.key -out client2.csr \
-subj '/C=CC/ST=CC/L=CC/O=CC Ltd/OU=CC/CN=*.client2.com/emailAddress=*.client2.com'
openssl x509 -req -extensions usr_cert -days 365 -CA sec-ca2.pem -CAkey sec-ca2.key \
-CAcreateserial -in client2.csr -out client2.pem

cat client2.pem >> client2-all.pem
cat sec-ca2.pem >> client2-all.pem
cat root-ca2.pem >> client2-all.pem
