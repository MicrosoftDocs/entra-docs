


Indexing the 'employeeId' Attribute for Microsoft Entra Inbound Provisioning to Active Directory
Essential Guidance for Optimizing Synchronization Performance
Microsoft Entra inbound provisioning enables organizations to automate user account creation and updates in on-premises Active Directory (AD) environments from sources such as Workday, SuccessFactors, or API-driven integrations. To ensure smooth and efficient synchronization, it is important to understand the role of attribute indexing—particularly the employeeId attribute, which is used as the default matching property during provisioning.
Why Indexing employeeId Is Needed
By default, the employeeId attribute is not indexed in Active Directory. However, indexing this attribute is strongly recommended because it is used as the primary property to match identities between Microsoft Entra and AD during both full and incremental provisioning runs. Without indexing, directory lookups can become significantly slower as your user base grows, potentially impacting synchronization performance and increasing provisioning times. Indexing ensures that these operations are completed efficiently and reliably.
Scope: Applies to Multiple Provisioning Scenarios
This guidance applies to all Microsoft Entra inbound provisioning scenarios that synchronize identities to on-premises AD, including:
* Workday to Active Directory provisioning
* SuccessFactors to Active Directory provisioning
* API-driven inbound provisioning to Active Directory
Multiple Matching Properties
If your provisioning setup uses more than one matching property (for example, employeeId and mail), be sure to check that each property is indexed in Active Directory. Indexing all matching properties used in synchronization helps maintain optimal performance and reduces the risk of delays or timeouts during provisioning runs.
Impact on Active Directory Domain Storage
Enabling indexing for additional attributes such as employeeId will increase storage requirements within your AD domain. While the storage impact is typically modest, it is important to consider this when planning large-scale deployments or when working with domains that have limited available resources.
How to Use the AD Schema Snap-in to Index an Attribute (e.g., employeeId) 
1. Prepare the Environment
* Ensure you are a member of the Schema Admins group in Active Directory.
* The AD Schema snap-in is not registered by default. You must register it first.
2. Register the Schema Snap-in
* Open a Command Prompt as Administrator.
* Run:
regsvr32 schmmgmt.dll
* You should see a confirmation dialog that the registration succeeded.
3. Open the Schema Snap-in
* Press Win + R, type mmc, and press Enter to open the Microsoft Management Console.
* In the MMC, go to File > Add/Remove Snap-in.
* Select Active Directory Schema from the list and click Add, then OK.
4. Locate the Attribute to Index
* In the left pane, expand Active Directory Schema and select Attributes.
* Scroll through the list to find the attribute you want to index (e.g., employeeId).
5. Edit Attribute Properties
* Right-click the attribute (e.g., employeeId) and select Properties.
* In the properties dialog, check the box labeled "Index this attribute in the Active Directory" (or similar wording, depending on your Windows Server version).

6. Apply and Replicate Changes
* Click OK to save your changes.
* Schema changes are replicated to all domain controllers. It may take some time for the change to propagate.
Further Resources
* To check if your Active Directory attribute used as matching identifier is indexed by default refer to this list - Indexed Attributes (AD Schema) - Win32 apps | Microsoft Learn
* To verify if the server is using an index to process the query refer to this article - Indexed Attributes (AD DS) - Win32 apps | Microsoft Learn 
* A practical blog post that explains the importance of indexing - Indexing Attributes in Active Directory

