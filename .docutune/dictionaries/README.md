# DocuTune Security package

The *.json* files listed in this directory are important files in DocuTune's security package workflow. Please read carefully.

The DocuTune security package released in v1.5.2 contains three different dictionaries to deal with three types of values associated with sensitive terms; GUIDs, thumbprints, and secrets. 

The dictionary file in DocuTune, *Dictionary-Security-{VALUE}.ps1* uses an `Invoke-WebRequest` to extract the information contained in the "dummy" and "known" files in this directory. The dummy files, *dummy-{ID}.json* provides a list of dummy values to be used for each defined sensitive term. The known files, *known-{ID}.json* provides a list of known values that DocuTune will ignore.

DocuTune checks the *known-{VALUE}.json* files to determine if a value is known and should be ignored, and stores it. It then adds the dummy values to the dictionary.

For any questions, contact [contentsecurityexperts@service.microsoft.com](mailto:contentsecurityexperts@service.microsoft.com)

## GUID files

 - [dummy-guids.json](./dummy-guids.json) : Lists out all the dummy GUID values to be used in written content, code samples, screenshots and other customer facing media.
 - [known-guids.json](./known-guids.json) : Lists out all the known GUID values in Microsoft content. This file can be edited to add new GUIDs as they are discovered. Contact [contentsecurityexperts@service.microsoft.com](mailto:contentsecurityexperts@service.microsoft.com) to report new GUIDs.

## Thumbprint files

- [dummy-thumbprints.json](./dummy-thumbprints.json) : Lists out all the dummy thumbprint values to be used in written content, code samples, screenshots and other customer facing media.
- [known-thumbprints.json](./known-thumbprints.json) : Empty json file used in the DocuTune workflow. This should not be edited as no thumbprints should be exposed.

## Secrets files

- [dummy-secrets.json](./dummy-secrets.json) : Lists out all the dummy secret values to be used in written content, code samples, screenshots and other customer facing media.
- [known-secrets.json](./known-secrets.json) : Empty json file used in the DocuTune workflow. This should not be edited as no secrets should be exposed.

## Other files

- [allowed-links.json](./allowed-links.json) : Lists out all the allowed links in Microsoft content. These links include GUIDs that should not be replaced.
- [dummy-hashs.json](./dummy-hashs.json) : Lists out all the dummy hash values to be used in written content, code samples, screenshots and other customer facing media. (NOT CURRENTLY USED in v1.5.2)
- [known-hashs.json](./known-hashs.json) : Empty json file (NOT CURRENTLY USED in v1.5.2)