# Btc-signature-check
## Checking from Stacks contract the truth of a Btc address ownership

How Bitcoin keys are generated is shown below.
![https://github.com/cryptopanter/Btc-signature-check/blob/main/msbt_0401.png](https://github.com/cryptopanter/Btc-signature-check/blob/main/msbt_0401.png)

However, we have different type of Bitcoin addresses on Bitcoin network.So we need to detect the type at first to convert them into the right pubkey.

Here you can convert your pubkey into Bitcoin address or vice versa: https://bitcointools.site/tool/address-to-pubkey

The public key can only be used to receive funds, and the private key is used to sign transactions to spend the funds. There is a mathematical relationship between the public and the private key that allows the private key to be used to generate signatures on messages. This signature can be validated against the public key without revealing the private key.

Elliptic curve multiplication is a type of function that cryptographers call a “trap door” function: it is easy to do in one direction (multiplication) and impossible to do in the reverse direction (division). (https://www.oreilly.com/library/view/mastering-bitcoin-2nd/9781491954379/ch04.html)

The **bitcoin address** is derived from the public key through the use of one-way cryptographic hashing. A “hashing algorithm” or simply “hash algorithm” is a one-way function. The algorithms used to make a bitcoin address from a public key are the Secure Hash Algorithm SHA256. Then again it goes through another Hash160 one-way function. And at the end, they are encoded in BASE58 to be more compact and easy-to-read (BASE58 is NOT one-way function).

![https://github.com/cryptopanter/Btc-signature-check/blob/main/Bitcoin%20address%20encoded.png](https://github.com/cryptopanter/Btc-signature-check/blob/main/Bitcoin%20address%20encoded.png)
So for decompressing Bitcoin addresses : BASE58 decoded -> Hex uncompressed address
and for compressing Bitcoin adresseses: HEX encoded -> BASE58 compressed address 
