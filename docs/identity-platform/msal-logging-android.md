---
title: Logging errors and exceptions in MSAL for Android.
description: Learn how to log errors and exceptions in MSAL for Android.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: devx-track-extended-java
ms.date: 01/25/2021
ms.reviewer: saeeda, negoe
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an Android developer, I want to enable logging in MSAL for Android using Java, so that I can capture and analyze log messages for troubleshooting and debugging purposes.
---
# Logging in MSAL for Android

[!INCLUDE [MSAL logging introduction](./includes/error-handling-and-tips/error-logging-introduction.md)]

## Logging in MSAL for Android using Java

Turn logging on at app creation by creating a logging callback. The callback takes these parameters:

- `tag` is a string passed to the callback by the library. It's associated with the log entry and can be used to sort logging messages.
- `logLevel` enables you to decide which level of logging you want. The supported log levels are: `Error`, `Warning`, `Info`, and `Verbose`.
- `message` is the content of the log entry.
- `containsPII` specifies whether messages containing personal data, or organizational data are logged. By default, this is set to false, so that your application doesn't log personal data. If `containsPII` is `true`, this method will receive the messages twice: once with the `containsPII` parameter set to `false` and the `message` without personal data, and a second time with the `containsPii` parameter set to `true` and the message might contain personal data. In some cases (when the message doesn't contain personal data), the message will be the same.

```java
private StringBuilder mLogs;

mLogs = new StringBuilder();
Logger.getInstance().setExternalLogger(new ILoggerCallback()
{
   @Override
   public void log(String tag, Logger.LogLevel logLevel, String message, boolean containsPII)
   {
      mLogs.append(message).append('\n');
   }
});
```

By default, the MSAL logger won't capture any personal identifiable information or organizational identifiable information.
To enable the logging of personal identifiable information or organizational identifiable information:

```java
Logger.getInstance().setEnablePII(true);
```

To disable logging personal data and organization data:

```java
Logger.getInstance().setEnablePII(false);
```

By default logging to logcat is disabled. To enable:

```java
Logger.getInstance().setEnableLogcatLog(true);
```

## Next steps

For more code samples, refer to [Microsoft identity platform code samples](sample-v2-code.md).
