#  Security Topics

Last updated: August 22, 2020


## Table of Contents

1. Encryption 
2. Keychain
3. Certificate Pinning
4. Other Security Resources
5. References and Links


## 1. Encryption 

A few options exist for Encryption. 

1. CommonCrypto (a C-level library)
2. CryptoKit (iOS 13+, only)
3. some third-party or custom option (CryptoSwift, etc)

These all implement common encryption and hashing functionalities. It's important to remember what purpose/algorithm you intend to use.

### Hashing:
* SHA, usually SHA-256 or SHA-512
* see `EncryptionSample`'s `CryptoAlgs` folder for usage. Also included are some tests.

### Encryption/Decryption with Public/Private Keys
* Symmetric Encryption (AES, SHA, etc)
* Asymmetric Encryption (RSA and others)

* data can be encrypted/decrypted to/from disk, and the key(s) can be kept in the Keychain.
* (this part in `EncryptionSample` isn't-quite working, yet)

## 2. Keychain

The secure store for small, sensitive data, being a best-practive location to store items such as private keys, certificates, passwords, etc.

The Keychain is kept in the Secure Enclave, and exists outside of the sandbox of an iOS application. As a result, deleting the app **will not** clear the Keychain. A reinstallation/latter-installation onto a device **can** use data previously-stored in the Keychain.

Usually, a work-around with a flag in UserDefaults is applied, in the following algorithm:

#### Keychain-clearing Workaround Algorithm
1. On any Keychain-use/application start: check if a Keychain-using flag is set in the UserDefaults
2. If it is not set, clear the data in the Keychain
3. Set a Keychain-using flag in the Keychain

`KeychainClearingSample`  uses a modified version of this algorithm; in which the check occurs on each Keychain-use, keeping a Keychain object in memory only when it is being used. 


## 3. Certificate Pinning

See `CertificatePinningSample`'s README for more insight, here.


## 4. Other Security Resources

https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/generating_new_cryptographic_keys?language=objc

https://www.raulferrergarcia.com/en/cryptokit-tutorial-how-to-use-cryptokit-on-ios13-apps/

https://developer.apple.com/library/archive/samplecode/GenericKeychain/Introduction/Intro.html#//apple_ref/doc/uid/DTS40007797-Intro-DontLinkElementID_2


## 5. References and Links

https://passwordsgenerator.net/md5-hash-generator/

https://emn178.github.io/online-tools/sha256.html

 https://8gwifi.org/CipherFunctions.jsp
