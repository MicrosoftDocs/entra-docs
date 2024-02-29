---
title: Entra ID interaction with provider
description: Learn about Entra ID interaction with provider


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/27/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa
---
# Entra ID interaction with provider

## Discovery of provider metadata 

An external identity provider will need to provide an [OIDC Discovery endpoint](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig). This endpoint will be used to retrieve additional configuration data. The full URL, including .well-known/oidc-configuration, must be included in the Discovery URL configured when creating the external authentication method. The endpoint will return a Provider Metadata JSON document hosted there. The endpoint must also return the valid content-length header.

The following table lists the data that should be present in the metadata of the provider. The JSON metadata document may contain additional information in addition to these fields that are required for this extensibility scenario.
The OIDC document specifying the values for Provider Metadata can be found
