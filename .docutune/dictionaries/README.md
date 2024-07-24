# DocuTune Security package

The *.json* files listed in this directory are important files in DocuTune's security package workflow. Please read carefully.

The DocuTune security package released in v1.5.2 contains three different dictionaries to deal with three types of values associated with sensitive terms; GUIDs, thumbprints, and secrets. 

The dictionary file in DocuTune, *Dictionary-Security-{VALUE}.ps1* uses an `Invoke-WebRequest` to extract the information contained in the "dummy" and "known" files in this directory. The dummy files, *dummy-{ID}.json* provides a list of dummy values to be used for each defined sensitive term. The known files, *known-{ID}.json* provides a list of known values that DocuTune will ignore.

DocuTune checks the *known-{VALUE}.json* files to determine if a value is known and should be ignored, and stores it. It then adds the dummy values to the dictionary.

Comments have been made in each of the following files as to their purpose and how they should be used.

- [dummy-guids.json](./dummy-guids.json)
- [known-guids.json](./known-guids.json)
- [dummy-thumbprints.json](./dummy-thumbprints.json)
- [known-thumbprints.json](./known-thumbprints.json)
- [dummy-secrets.json](./dummy-secrets.json)
- [known-secrets.json](./known-secrets.json)
- [dummy-hashs.json](./dummy-hashs.json)
- [known-hashs.json](./known-hashs.json)
- [allowed-links.json](./allowed-links.json)

For any questions, contact [contentsecurityexperts@service.microsoft.com](mailto:contentsecurityexperts@service.microsoft.com)