#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"

#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

@interface StringEncryption : NSObject

+ (NSString *)encryptString:(NSString *)plainSourceStringToEncrypt encryptKey:(NSString *)encryptKey;
+ (NSString *)decryptString:(NSString *)base64StringToDecrypt encryptKey:(NSString *)encryptKey;
+ (NSData *)encrypt:(NSData *)plainText encryptKey:(NSString *)encryptKey;
+ (NSData *)decrypt:(NSData *)plainText encryptKey:(NSString *)encryptKey;
+ (NSData *)doCipher:(NSData *)plainText encryptKey:(NSString *)encryptKey context:(CCOperation)encryptOrDecrypt;

@end
