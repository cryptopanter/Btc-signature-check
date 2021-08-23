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

## Public key formats
Public keys are also presented in different ways, usually as either compressed or uncompressed public keys.
As we saw previously, the public key is a point on the elliptic curve consisting of a pair of coordinates (x,y). It is usually presented with the prefix 04 followed by two 256-bit numbers: one for the x coordinate of the point, the other for the y coordinate. The prefix 04 is used to distinguish uncompressed public keys from compressed public keys that begin with a 02 or a 03.

Here’s the public key generated by the private key we created earlier, shown as the coordinates x and y:


x = F028892BAD7ED57D2FB57BF33081D5CFCF6F9ED3D3D7F159C2E2FFF579DC341A
y = 07CF33DA18BD734C600B96A72BBC4749D5141C90EC8AC328AE52DDFE2E505BDB

Here’s the same public key shown as a 520-bit number (130 hex digits) with the prefix 04 followed by x and then y coordinates, as 04 x y:

K = 04F028892BAD7ED57D2FB57BF33081D5CFCF6F9ED3D3D7F159C2E2FFF579DC341A↵
07CF33DA18BD734C600B96A72BBC4749D5141C90EC8AC328AE52DDFE2E505BDB
more:  https://www.oreilly.com/library/view/mastering-bitcoin-2nd/9781491954379/ch04.html


As we know, **traditional bitcoin addresses begin with the number “1”** and are derived from the public key, which is derived from the private key. Although anyone can send bitcoin to a “1” address, that bitcoin can only be spent by presenting the corresponding private key signature and public key hash.

**Bitcoin addresses that begin with the number “3”** are pay-to-script hash (P2SH) addresses, sometimes erroneously called multisignature or multisig addresses. They designate the beneficiary of a bitcoin transaction as the hash of a script, instead of the owner of a public key. The feature was introduced in January 2012 with BIP-16 (see Appendix C), and is being widely adopted because it provides the opportunity to add functionality to the address itself. Unlike transactions that “send” funds to traditional “1” bitcoin addresses, also known as a pay-to-public-key-hash (P2PKH), funds sent to “3” addresses require something more than the presentation of one public key hash and one private key signature as proof of ownership. The requirements are designated at the time the address is created, within the script, and all inputs to this address will be encumbered with the same requirements.

A P2SH address is created from a transaction script, which defines who can spend a transaction output (for more details, see “Pay-to-Script-Hash (P2SH)”). Encoding a P2SH address involves using the same double-hash function as used during creation of a bitcoin address, only applied on the script instead of the public key:

script hash = RIPEMD160(SHA256(script))

Therefore Bitcoin addresses are generated as follows: 


**1)"P2SH -> starts with 3"**

**2) "P2PK -> starts with 1"**

**3) "Bech32 -> starts with bc1"**


And Pub keys are generated as follows: 
**"compressed -> starts with 02 or 03",
"uncompressed -> starts with 04"**

## Electrum Wallet
Your private keys need to be in Wallet Import Format (WIF), BASE58,  or mini private key format.  (https://en.bitcoin.it/wiki/Private_key#Base58_Wallet_Import_format)
When importing or sweeping ECDSA private keys, a shorter format known as wallet import format is often used, which offers a few advantages. The wallet import format is **shorter**, and includes **built-in error checking codes** so that typos can be automatically detected and/or corrected (which is **impossible** in hex format) and type bits indicating how it is intended to be used. Wallet import format is the most common way to represent private keys in Bitcoin. For **private keys associated with uncompressed public** keys, they are 51 characters and always start with the number 5 on mainnet (9 on testnet). **Private keys associated with compressed public keys** are 52 characters and start with a capital L or K on mainnet (c on testnet). 

**Note:** if the addresses in the originating wallet of the private keys begin with 3 you have to prepend “p2wpkh-p2sh:” to each private key before sweeping it. If the addresses begin with bc1 then you prepend “p2wpkh:”. Click on the info button to see examples.



## appendix
converting text to sha256: https://md5decrypt.net/en/Sha256/
