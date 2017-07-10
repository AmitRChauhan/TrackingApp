//
//  NSString+Encryption.m
//  VPassbook
//
//  Created by Avinash on 03/10/13.
//  Copyright (c) 2013 Snowtint Technologies Pvt. Ltd. All rights reserved.
//

#import "NSString+Encryption.h"


@implementation NSString (Encryption)
//          <-----.NET Version----->
//public static string getEncryptString(string strData, string key)
//{
//    
//    string checkSumValue = CalculateMD5Hash(strData);
//    string strDataWithCheckSum = strData + "|checkSum=" + checkSumValue;
//    return Encrypt(strDataWithCheckSum, key);
//}

- (NSString*)encryptedStringWithKey:(NSString*)key {
    NSString* SHA1String = [[self SHA1EncodedString] uppercaseString];
    NSString* hashWithChecksum = [NSString stringWithFormat:@"%@|checkSum=%@", SHA1String, [SHA1String md5HexDigest]];
    
    return [NSString AESEncrypt:hashWithChecksum withKey:key];
}

//          <-----.NET Version----->
//public static string CalculateMD5Hash(string strInput)
//{
//    MD5 md5 = System.Security.Cryptography.MD5.Create();
//    byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(strInput);
//    byte[] hash = md5.ComputeHash(inputBytes);
//    
//    StringBuilder sb = new StringBuilder();
//    for (int i = 0; i < hash.Length; i++)
//    {
//        sb.Append(hash[i].ToString("x2"));
//    }
//    return sb.ToString();
//}

- (NSString*)md5HexDigest {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

//          <-----.NET Version----->
//private static string Encrypt(string textToEncrypt, string key)
//{
//    RijndaelManaged rijndaelCipher = new RijndaelManaged();
//    rijndaelCipher.Mode = CipherMode.CBC;
//    rijndaelCipher.Padding = PaddingMode.PKCS7;
//    rijndaelCipher.KeySize = 0x80;
//    rijndaelCipher.BlockSize = 0x80;
//    byte[] pwdBytes = Encoding.UTF8.GetBytes(key);
//    byte[] keyBytes = new byte[0x10];
//    int len = pwdBytes.Length;
//    if (len > keyBytes.Length)
//    {
//        len = keyBytes.Length;
//    }
//    Array.Copy(pwdBytes, keyBytes, len);
//    rijndaelCipher.Key = keyBytes;
//    rijndaelCipher.IV = keyBytes;
//    ICryptoTransform transform = rijndaelCipher.CreateEncryptor();
//    byte[] plainText = Encoding.UTF8.GetBytes(textToEncrypt);
//    return Convert.ToBase64String(transform.TransformFinalBlock(plainText, 0, plainText.Length));
//}

+ (NSString*)AESDecrypt:(NSString*)string withKey:(NSString*)key hasChecksumHash:(BOOL)conatainsHash {
//    NSString* decryptedString1 = [NSString AESDecrypt:@"D8fZfEf9CwANKCBb961pB7+McuocJiVpIQtPWi+4fjc1C6FGEqXhPGDHqE4lRKD+" withKey:key];
    NSString* decryptedString = [NSString AESDecrypt:string withKey:key];
    if( conatainsHash ) {
        NSArray* components = [decryptedString componentsSeparatedByString:@"|checkSum="];
        if( [components count] ) {
            decryptedString = [components objectAtIndex:0];
        }
    }
    
    return decryptedString;
}

+ (NSString*)AESDecrypt:(NSString*)string withKey:(NSString*)key {
    NSData* keyData = [NSData dataWithBytesNoCopy:(void*)[key cStringUsingEncoding:NSUTF8StringEncoding]
                                           length:[key length]
                                     freeWhenDone:NO];
    NSData *encryptedData = [NSData dataFromBase64String:string];
    NSData* decryptedData = [encryptedData decryptedDataUsingAESKey:keyData];
    NSString* decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return decryptedString ;
}

+ (NSString*)AESEncrypt:(NSString*)string withKey:(NSString*)key addChecksumHash:(BOOL)needsHash {
    NSString* encryptedString = [NSString AESEncrypt:needsHash ? [NSString stringWithFormat:@"%@|checkSum=%@", string, [string md5HexDigest]] : string withKey:key];
    return encryptedString;
}

+ (NSString*)AESEncrypt:(NSString*)string withKey:(NSString*)key {
    NSData* data = [NSData dataWithBytesNoCopy:(void*)[string cStringUsingEncoding:NSUTF8StringEncoding]
                                       length:[string length]
                                  freeWhenDone:NO];
    
    NSData* keyData = [NSData dataWithBytesNoCopy:(void*)[key cStringUsingEncoding:NSUTF8StringEncoding]
                                        length:[key length]
                                 freeWhenDone:NO];
    
    NSData *encryptedData = [data encryptedDataUsingAESKey:keyData];
    NSString* base64EncodedString = [encryptedData base64EncodedString];
    
    return base64EncodedString;
}

@end
