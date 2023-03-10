# Generated with Microsoft365DSC version 1.22.1221.1
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
param (
    [parameter()]
    [System.Management.Automation.PSCredential]
    $Credential
)

Configuration M365TenantConfig
{
    param (
        [parameter()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    if ($null -eq $Credential)
    {
        <# Credentials #>
        $Credscredential = Get-Credential -Message "Credentials"

    }
    else
    {
        $CredsCredential = $Credential
    }

    $OrganizationName = $CredsCredential.UserName.Split('@')[1]

    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.22.1221.1'

    Node localhost
    {
        EXOApplicationAccessPolicy 96eed8b9-665b-4e9e-9f2f-96dd86d3c180
        {
            AccessRight          = "RestrictAccess";
            AppID                = "44534dca-f13c-41ec-8050-51f0c036c219";
            Credential           = $Credscredential;
            Description          = "Restrict this app to members of distribution group even users.";
            Ensure               = "Present";
            Identity             = "79a2fbbe-f26b-4ab8-ab20-5223e4c2f62d\44534dca-f13c-41ec-8050-51f0c036c219:S-1-5-21-4112488020-863137326-2000415224-33472354;ebf421e8-3ad7-48f7-826f-d725160b686b";
            PolicyScopeGroupId   = "SG_AppMailboxAccess20210109024250";
        }
        EXOAtpPolicyForO365 171d67e5-a48d-49cd-af03-9a5ce977a6a3
        {
            AllowSafeDocsOpen       = $False;
            Credential              = $Credscredential;
            EnableATPForSPOTeamsODB = $True;
            EnableSafeDocs          = $True;
            Ensure                  = "Present";
            Identity                = "Default";
            IsSingleInstance        = "Yes";
        }
        EXOEmailAddressPolicy 4c1b42dd-6689-41eb-ab94-6594a3873417
        {
            Credential                        = $Credscredential;
            EnabledEmailAddressTemplates      = @("SMTP:@dmcsandbox.onmicrosoft.com");
            EnabledPrimarySMTPAddressTemplate = "@dmcsandbox.onmicrosoft.com";
            Ensure                            = "Present";
            ManagedByFilter                   = "";
            Name                              = "Default Policy";
            Priority                          = "Lowest";
        }
        EXOHostedConnectionFilterPolicy 8fa391ff-bc3c-46bd-b720-56605f6985d4
        {
            AdminDisplayName     = "";
            Credential           = $Credscredential;
            EnableSafeList       = $False;
            Ensure               = "Present";
            Identity             = "Default";
            IPAllowList          = @();
            IPBlockList          = @();
            MakeDefault          = $False;
        }
        EXOHostedContentFilterPolicy da16aa94-f41d-47e1-ac27-949d43603be3
        {
            AddXHeaderValue                      = "";
            AdminDisplayName                     = "";
            BulkQuarantineTag                    = "DefaultFullAccessPolicy";
            BulkSpamAction                       = "MoveToJmf";
            BulkThreshold                        = 7;
            Credential                           = $Credscredential;
            DownloadLink                         = $False;
            EnableEndUserSpamNotifications       = $False;
            EnableLanguageBlockList              = $False;
            EnableRegionBlockList                = $False;
            EndUserSpamNotificationCustomSubject = "";
            EndUserSpamNotificationFrequency     = 3;
            EndUserSpamNotificationLanguage      = "Default";
            Ensure                               = "Present";
            HighConfidencePhishAction            = "Quarantine";
            HighConfidencePhishQuarantineTag     = "AdminOnlyAccessPolicy";
            HighConfidenceSpamAction             = "MoveToJmf";
            HighConfidenceSpamQuarantineTag      = "DefaultFullAccessPolicy";
            Identity                             = "Default";
            IncreaseScoreWithBizOrInfoUrls       = "Off";
            IncreaseScoreWithImageLinks          = "Off";
            IncreaseScoreWithNumericIps          = "Off";
            IncreaseScoreWithRedirectToOtherPort = "Off";
            InlineSafetyTipsEnabled              = $True;
            LanguageBlockList                    = @();
            MakeDefault                          = $True;
            MarkAsSpamBulkMail                   = "On";
            MarkAsSpamEmbedTagsInHtml            = "Off";
            MarkAsSpamEmptyMessages              = "Off";
            MarkAsSpamFormTagsInHtml             = "Off";
            MarkAsSpamFramesInHtml               = "Off";
            MarkAsSpamFromAddressAuthFail        = "Off";
            MarkAsSpamJavaScriptInHtml           = "Off";
            MarkAsSpamNdrBackscatter             = "Off";
            MarkAsSpamObjectTagsInHtml           = "Off";
            MarkAsSpamSensitiveWordList          = "Off";
            MarkAsSpamSpfRecordHardFail          = "Off";
            MarkAsSpamWebBugsInHtml              = "Off";
            ModifySubjectValue                   = "";
            PhishQuarantineTag                   = "DefaultFullAccessPolicy";
            PhishSpamAction                      = "MoveToJmf";
            PhishZapEnabled                      = $True;
            QuarantineRetentionPeriod            = 15;
            RedirectToRecipients                 = @();
            RegionBlockList                      = @();
            SpamAction                           = "MoveToJmf";
            SpamQuarantineTag                    = "DefaultFullAccessPolicy";
            SpamZapEnabled                       = $True;
            TestModeAction                       = "None";
            TestModeBccToRecipients              = @();
        }
        EXOHostedOutboundSpamFilterPolicy 5cf1b09b-fb7f-4ae6-b91a-cb5c59492762
        {
            ActionWhenThresholdReached                = "BlockUserForToday";
            AdminDisplayName                          = "";
            AutoForwardingMode                        = "Automatic";
            BccSuspiciousOutboundAdditionalRecipients = @();
            BccSuspiciousOutboundMail                 = $False;
            Credential                                = $Credscredential;
            Ensure                                    = "Present";
            Identity                                  = "Default";
            NotifyOutboundSpam                        = $False;
            NotifyOutboundSpamRecipients              = @();
            RecipientLimitExternalPerHour             = 0;
            RecipientLimitInternalPerHour             = 0;
            RecipientLimitPerDay                      = 0;
        }
        EXOIRMConfiguration 7053bf5c-2be8-4092-a737-9da9887c9793
        {
            AutomaticServiceUpdateEnabled              = $True;
            AzureRMSLicensingEnabled                   = $True;
            Credential                                 = $Credscredential;
            DecryptAttachmentForEncryptOnly            = $False;
            EDiscoverySuperUserEnabled                 = $True;
            EnablePdfEncryption                        = $False;
            Ensure                                     = "Present";
            Identity                                   = "ControlPoint Config";
            InternalLicensingEnabled                   = $True;
            JournalReportDecryptionEnabled             = $True;
            LicensingLocation                          = @("https://e5697441-46dd-4c18-95fc-63b7f0f22556.rms.na.aadrm.com/_wmcs/licensing");
            RejectIfRecipientHasNoRights               = $False;
            SearchEnabled                              = $True;
            SimplifiedClientAccessDoNotForwardDisabled = $False;
            SimplifiedClientAccessEnabled              = $True;
            SimplifiedClientAccessEncryptOnlyDisabled  = $False;
            TransportDecryptionSetting                 = "Optional";
        }
        EXOManagementRole 48768f65-94fd-408a-a445-aad7d8158a09
        {
            Credential           = $Credscredential;
            Description          = "";
            Ensure               = "Present";
            Name                 = "MyAddressInformation";
            Parent               = "dmcsandbox.onmicrosoft.com\MyContactInformation";
        }
        EXOManagementRole 7906cfec-e523-41e9-b477-777202c6aa56
        {
            Credential           = $Credscredential;
            Description          = "";
            Ensure               = "Present";
            Name                 = "MyMobileInformation";
            Parent               = "dmcsandbox.onmicrosoft.com\MyContactInformation";
        }
        EXOManagementRole 43fa01ab-d600-48be-981e-7303d32932da
        {
            Credential           = $Credscredential;
            Description          = "";
            Ensure               = "Present";
            Name                 = "MyPersonalInformation";
            Parent               = "dmcsandbox.onmicrosoft.com\MyContactInformation";
        }
        EXOManagementRole bf906d6a-51bf-40a5-9e5a-407e15ff0147
        {
            Credential           = $Credscredential;
            Description          = "";
            Ensure               = "Present";
            Name                 = "MyDisplayName";
            Parent               = "dmcsandbox.onmicrosoft.com\MyProfileInformation";
        }
        EXOManagementRole 9ee15f3a-b456-4b76-9679-2a219dc82568
        {
            Credential           = $Credscredential;
            Description          = "";
            Ensure               = "Present";
            Name                 = "MyName";
            Parent               = "dmcsandbox.onmicrosoft.com\MyProfileInformation";
        }
        EXOManagementRoleAssignment b53ea7c5-d87d-470b-9b53-8a3a57ad7e33
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "ApplicationImpersonation-RIM-MailboxAdminsdef60f480c7d4b889e8027";
            Role                 = "ApplicationImpersonation";
            SecurityGroup        = "RIM-MailboxAdminsdef60f480c7d4b889e802701b5f5922f";
        }
        EXOManagementRoleAssignment 7f91ba2e-bf19-457b-b2c6-ce13e92bb7c0
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyTextMessaging-Organization Management-Delegating";
            Role                 = "MyTextMessaging";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 55d11899-fb78-4928-b821-021422690e91
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyVoiceMail-Organization Management-Delegating";
            Role                 = "MyVoiceMail";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment ba12310f-38cc-49e7-80f6-e059809314d2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Mail.Read-Organization Management-Delegating";
            Role                 = "Application Mail.Read";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 2607721a-3b67-4e57-a056-2b2ebc753903
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Mail.ReadWrite-Organization Management-Delegating";
            Role                 = "Application Mail.ReadWrite";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment a77cdee2-20e4-4eb7-b6c5-2987ea08b4f7
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application EWS.AccessAsApp-Organization Management-Delegating";
            Role                 = "Application EWS.AccessAsApp";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 6be85362-19bd-493b-97d7-ea33caa1facb
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application MailboxSettings.Read-Organization Management-Delegat";
            Role                 = "Application MailboxSettings.Read";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment ccff6b61-71a0-460a-be48-a25300861a73
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Mail.Send-Organization Management-Delegating";
            Role                 = "Application Mail.Send";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment e440e203-13c1-4781-bdbb-a5ae688c1319
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Mail.ReadBasic-Organization Management-Delegating";
            Role                 = "Application Mail.ReadBasic";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7e01a37b-cf96-47a0-8ae6-bc59d4f306e9
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyVoiceMail-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyVoiceMail";
        }
        EXOManagementRoleAssignment a223f034-aba5-464c-9377-d4a33cf4cbd4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Contacts.Read-Organization Management-Delegating";
            Role                 = "Application Contacts.Read";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7c250fc5-8b04-49cc-9973-922d76350705
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application MailboxSettings.ReadWrite-Organization Management-De";
            Role                 = "Application MailboxSettings.ReadWrite";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7c5698eb-c025-4592-b84f-d368b052afc0
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Contacts.ReadWrite-Organization Management-Delegatin";
            Role                 = "Application Contacts.ReadWrite";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment d2b1936b-fb6d-478a-8d11-3262ab9fdf5f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyTextMessaging-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyTextMessaging";
        }
        EXOManagementRoleAssignment fde4bfa8-d407-44b1-8fc6-c7867e5400ea
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Exchange Full Access-Organization Management-Delegat";
            Role                 = "Application Exchange Full Access";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 072eb3cb-967c-46ee-bd75-ae1ee688be88
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Mail Full Access-Organization Management-Delegating";
            Role                 = "Application Mail Full Access";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment ec3e696a-aa1c-4709-8908-fa66c07279da
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Calendars.Read-Organization Management-Delegating";
            Role                 = "Application Calendars.Read";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 37ba8700-a6a6-4684-ad52-b0af788095dd
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Application Calendars.ReadWrite-Organization Management-Delegati";
            Role                 = "Application Calendars.ReadWrite";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b7907a30-1c56-4c0f-be3e-df3b96b46a2c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "My Custom Apps-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "My Custom Apps";
        }
        EXOManagementRoleAssignment 99743b4a-0030-4364-9797-2554d5a49cf5
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyDistributionGroups-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyDistributionGroups";
        }
        EXOManagementRoleAssignment 040afd4a-b4e6-4644-88af-ce34ed20ed10
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyDistributionGroupMembership-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyDistributionGroupMembership";
        }
        EXOManagementRoleAssignment 8f231692-00ff-47b6-b469-42b79d82c4ff
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyContactInformation-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyContactInformation";
        }
        EXOManagementRoleAssignment 1fc9efe1-206c-43f2-a3bb-5d885085864b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyBaseOptions-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyBaseOptions";
        }
        EXOManagementRoleAssignment 44cda4b6-3df9-4986-8d56-4667ae13eace
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyProfileInformation-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyProfileInformation";
        }
        EXOManagementRoleAssignment 7e14893e-060d-499d-b606-680baf8444ff
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "My Marketplace Apps-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "My Marketplace Apps";
        }
        EXOManagementRoleAssignment 3c0b017e-7b14-4e20-beaf-070a54e00f61
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyMailSubscriptions-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyMailSubscriptions";
        }
        EXOManagementRoleAssignment 56dcc90e-5aa9-4ae8-8536-6c94dc2383c0
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "My ReadWriteMailbox Apps-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "My ReadWriteMailbox Apps";
        }
        EXOManagementRoleAssignment 0271ca28-dab2-46fe-9bad-6c4b4ebf16f4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyRetentionPolicies-Default Role Assignment Policy";
            Policy               = "Default Role Assignment Policy";
            Role                 = "MyRetentionPolicies";
        }
        EXOManagementRoleAssignment f4c1092c-621a-472c-8f23-7152c70c7ec3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Tenant AllowBlockList Manager-Security Operator";
            Role                 = "Tenant AllowBlockList Manager";
            SecurityGroup        = "Security Operator";
        }
        EXOManagementRoleAssignment 06798991-cf6a-4bc5-9e31-4c9bcb6cf2da
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Tenant AllowBlockList Manager-Organization Management-Delegating";
            Role                 = "Tenant AllowBlockList Manager";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b31604d1-0c4e-4f8b-99e9-4ab92ec167ea
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MailboxSearchApplication-Organization Management-Delegating";
            Role                 = "MailboxSearchApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 26b3c123-866a-4e2d-9e8d-307c93cf33bd
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Data Loss Prevention-Organization Management-Delegating";
            Role                 = "Data Loss Prevention";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 59640f9b-0b3c-4a5a-a729-23c6843a9807
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Compliance Admin-Compliance Management";
            Role                 = "Compliance Admin";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 1c9ed68c-d694-4bea-bdd9-76dfad1d3872
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Enabled Public Folders-Organization Management";
            Role                 = "Mail Enabled Public Folders";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 393f3241-db79-4394-a981-3dd288bbf588
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Recipient Creation-Organization Management-Delegating";
            Role                 = "Mail Recipient Creation";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 76cf6a9a-6a87-4bb1-af99-a5f29ec8d87d
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Audit Logs-Compliance Management";
            Role                 = "View-Only Audit Logs";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment c2b5dc27-6071-4be6-a406-cafa549062be
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Message Tracking-Organization Management-Delegating";
            Role                 = "Message Tracking";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment f488fd43-2377-4811-aca3-f817d056f648
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Rules-Compliance Management";
            Role                 = "Transport Rules";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 22fa5a4f-9508-4fc6-a410-8e334945d251
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Migration-Organization Management-Delegating";
            Role                 = "Migration";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 9fc847bb-55fa-467f-b1b2-70f5ba58d156
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Org Marketplace Apps-Organization Management";
            Role                 = "Org Marketplace Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment e20648d7-6549-4ef7-87f6-28b3bc264b50
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Distribution Groups-Organization Management";
            Role                 = "Distribution Groups";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 57e3cbac-a5cf-4a8e-b35e-e9177f1ddef2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Org Marketplace Apps-Organization Management-Delegating";
            Role                 = "Org Marketplace Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1f00b080-0fba-401b-b817-9ca429f4745f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mailbox Search-Discovery Management";
            Role                 = "Mailbox Search";
            SecurityGroup        = "Discovery Management";
        }
        EXOManagementRoleAssignment 653454e9-5a67-4c01-8b3a-fd0611dc7173
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "E-Mail Address Policies-Organization Management";
            Role                 = "E-Mail Address Policies";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b1e770c0-a590-4319-8c66-bc61ff8788f3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Recipients-Organization Management-Delegating";
            Role                 = "Mail Recipients";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment c96bae1e-2b6d-4c4b-bec2-d08a92c77d8c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Configuration-Compliance Management";
            Role                 = "View-Only Configuration";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 84300a9d-7658-43a2-9613-95734a0ea8b8
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "ArchiveApplication-Organization Management-Delegating";
            Role                 = "ArchiveApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7aaf1965-a092-4590-8232-64b70cd7278c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Legal Hold-Organization Management";
            Role                 = "Legal Hold";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment c97ddab8-bb1c-4242-a937-9742696d7997
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Information Rights Management-Organization Management";
            Role                 = "Information Rights Management";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment ce386f82-41fe-48ee-9a19-7241558eae80
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Audit Logs-Compliance Management";
            Role                 = "Audit Logs";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 6c8c9400-8e3b-49f9-b7e3-967f7c283421
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Federated Sharing-Organization Management";
            Role                 = "Federated Sharing";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 52cb1ada-3873-490e-8415-483e4b5a1f0a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Recipients-Hygiene Management";
            Role                 = "View-Only Recipients";
            SecurityGroup        = "Hygiene Management";
        }
        EXOManagementRoleAssignment e3df9e49-7076-462c-869e-210e87a510be
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Tips-Organization Management-Delegating";
            Role                 = "Mail Tips";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 218c43ac-ae0b-41d2-aac9-e4bff06e2853
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mailbox Import Export-Organization Management-Delegating";
            Role                 = "Mailbox Import Export";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 9765e98c-53a2-4649-8cb7-24936e76a36f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Move Mailboxes-Organization Management";
            Role                 = "Move Mailboxes";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 9c997855-e2c7-4874-a8db-bf2aa1214203
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "ApplicationImpersonation-Organization Management-Delegating";
            Role                 = "ApplicationImpersonation";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 07fec435-acab-4f83-b908-5f3824c846a2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Audit Logs-Organization Management-Delegating";
            Role                 = "Audit Logs";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 8fa4fdee-4d61-410f-bad7-3f9a1ccd8f0a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Journaling-Organization Management";
            Role                 = "Journaling";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 13efbe45-9299-4b12-a63f-d06dc1374085
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Reset Password-Help Desk";
            Role                 = "Reset Password";
            SecurityGroup        = "Help Desk";
        }
        EXOManagementRoleAssignment 78e89f32-3039-4685-addf-46d3b1ab834a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Hygiene-Hygiene Management";
            Role                 = "Transport Hygiene";
            SecurityGroup        = "Hygiene Management";
        }
        EXOManagementRoleAssignment d3c30837-1cff-4a0e-b625-4809af579878
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Address Lists-Organization Management-Delegating";
            Role                 = "Address Lists";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment c2ca0360-ff43-4849-84bf-61e2aa7dad75
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Distribution Groups-Organization Management-Delegating";
            Role                 = "Distribution Groups";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment a0bf65b4-d95a-4e73-89cd-0b50651f9710
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "User Options-Help Desk";
            Role                 = "User Options";
            SecurityGroup        = "Help Desk";
        }
        EXOManagementRoleAssignment 5296b913-f01e-4964-9b9d-24ff3b1b7250
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "E-Mail Address Policies-Organization Management-Delegating";
            Role                 = "E-Mail Address Policies";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment d64816b1-9793-4722-b298-53731956a24a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Organization Client Access-Organization Management-Delegating";
            Role                 = "Organization Client Access";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7632681e-f3e8-4148-89b5-9f94f75f20b4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Recipients-Organization Management";
            Role                 = "Mail Recipients";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 4c9b973f-5bcd-41c4-aa59-c31d823fe6ba
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Legal Hold-Organization Management-Delegating";
            Role                 = "Legal Hold";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 37a41e8d-1dce-4af3-98c8-1f240ece363c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Move Mailboxes-Organization Management-Delegating";
            Role                 = "Move Mailboxes";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1377f0c3-f1ba-4bde-b073-832b0a5706cc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Recipients-Help Desk";
            Role                 = "View-Only Recipients";
            SecurityGroup        = "Help Desk";
        }
        EXOManagementRoleAssignment 1f016fae-e0eb-4da5-bdef-d47dcf88cb96
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Journaling-Organization Management-Delegating";
            Role                 = "Journaling";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment a0856d24-26a3-4185-b6b7-cf1d30d26bc1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Information Rights Management-Organization Management-Delegating";
            Role                 = "Information Rights Management";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment ff6a4b5c-c315-4135-8498-4958f5959cf8
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Configuration-Hygiene Management";
            Role                 = "View-Only Configuration";
            SecurityGroup        = "Hygiene Management";
        }
        EXOManagementRoleAssignment bb13e93a-587f-487c-888a-fcae495474c1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Journaling-Compliance Management";
            Role                 = "Journaling";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 865c73d1-a552-4dda-b6c8-b1cc4ba12f58
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Recipients-Compliance Management";
            Role                 = "View-Only Recipients";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 8afac3a6-63f5-4989-914b-e750087539f6
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Tips-Organization Management";
            Role                 = "Mail Tips";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 596480df-c823-4a41-8f76-b09d60b938b0
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Org Custom Apps-Organization Management";
            Role                 = "Org Custom Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7e995056-70be-4d07-8e1c-1cdd1945d517
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Enabled Public Folders-Organization Management-Delegating";
            Role                 = "Mail Enabled Public Folders";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment f82e57c0-72bf-4a2c-baed-a93eec5d707c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Data Loss Prevention-Organization Management";
            Role                 = "Data Loss Prevention";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment c29a965e-aedd-422b-aeb7-f275542d40f3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Message Tracking-Organization Management";
            Role                 = "Message Tracking";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 854cd8b1-3068-4ce4-af10-3e5591e6f860
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Compliance Admin-Organization Management-Delegating";
            Role                 = "Compliance Admin";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 473ae6ed-a0c0-42c2-8144-493e68352d25
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Legal Hold-Discovery Management";
            Role                 = "Legal Hold";
            SecurityGroup        = "Discovery Management";
        }
        EXOManagementRoleAssignment 55a379ec-3b62-4f58-965b-9e0d6313089f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Data Loss Prevention-Compliance Management";
            Role                 = "Data Loss Prevention";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 26994897-5c84-409b-8455-b31a4b8ccd9c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mailbox Search-Organization Management-Delegating";
            Role                 = "Mailbox Search";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 71463fcc-9d70-4e28-89e4-f57f91467e38
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Compliance Admin-Organization Management";
            Role                 = "Compliance Admin";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 998f242a-07a0-4f88-be5a-4c3ff946887e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Retention Management-Compliance Management";
            Role                 = "Retention Management";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 477bc10a-b435-4880-ab61-139fa90c7251
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Information Rights Management-Compliance Management";
            Role                 = "Information Rights Management";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 95b9cd0e-ee38-4833-bfc3-9fde8913340e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Migration-Organization Management";
            Role                 = "Migration";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment e963ba67-eeec-491f-8c8b-3d19bc75df99
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "OfficeExtensionApplication-Organization Management-Delegating";
            Role                 = "OfficeExtensionApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1de79dd5-9c41-4fd6-931d-956aca6f1f81
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Message Tracking-Compliance Management";
            Role                 = "Message Tracking";
            SecurityGroup        = "Compliance Management";
        }
        EXOManagementRoleAssignment 22f1a794-98fb-41e3-a99c-a0521a7f2215
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Recipient Creation-Organization Management";
            Role                 = "Mail Recipient Creation";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b2d2a15a-0a90-4736-96a0-9cc932f70ec2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Org Custom Apps-Organization Management-Delegating";
            Role                 = "Org Custom Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 79e44b6e-aeef-4955-8b80-e6c77a70fda0
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "LegalHoldApplication-Organization Management-Delegating";
            Role                 = "LegalHoldApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment e650efce-2df1-4b6b-b02d-644f81e5ceb9
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MeetingGraphApplication-Organization Management-Delegating";
            Role                 = "MeetingGraphApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1f7ffa76-dde2-47e3-aa88-f785bc4c1780
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Audit Logs-Organization Management";
            Role                 = "Audit Logs";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1d5699ce-6958-4e58-b2a1-af9329bf53b1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Federated Sharing-Organization Management-Delegating";
            Role                 = "Federated Sharing";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 11df4030-5e72-49f2-90ee-f26f85078bb1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "My Custom Apps-Organization Management-Delegating";
            Role                 = "My Custom Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 032d0c10-41da-4b9e-9888-44e9252680ec
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UserApplication-Organization Management-Delegating";
            Role                 = "UserApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 5369f821-3ccc-4a2e-ba0c-9d91f5da0c23
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Retention Management-Records Management";
            Role                 = "Retention Management";
            SecurityGroup        = "Records Management";
        }
        EXOManagementRoleAssignment b479a597-7a11-4c49-9a6d-44799ed2d0e1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UM Prompts-UM Management";
            Role                 = "UM Prompts";
            SecurityGroup        = "UM Management";
        }
        EXOManagementRoleAssignment b1b8a8f5-1564-48f0-8403-eb04c3e2651c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Admin-Organization Management";
            Role                 = "Security Admin";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment f52099c9-ccb1-43a1-b837-7ec164bcc226
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Distribution Groups-Recipient Management";
            Role                 = "Distribution Groups";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 0e9164c3-e08b-4545-bf0f-5e81342312f6
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Recipient Policies-Recipient Management";
            Role                 = "Recipient Policies";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 3ff458ad-5fa9-435d-ae31-fff762a56920
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Configuration-View-Only Organization Management";
            Role                 = "View-Only Configuration";
            SecurityGroup        = "View-Only Organization Management";
        }
        EXOManagementRoleAssignment fbf93f4f-dc40-4b46-83b6-a0039eb6d0e9
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyContactInformation-Organization Management-Delegating";
            Role                 = "MyContactInformation";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment aa6fc3e3-8725-465a-bb21-240f72d2b9fa
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Reset Password-Organization Management-Delegating";
            Role                 = "Reset Password";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 2313f2c3-b77f-4134-bbb2-5457127286e9
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Recipient Policies-Organization Management-Delegating";
            Role                 = "Recipient Policies";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7462bf99-3e0e-484b-848d-6eb42d15f152
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Configuration-Organization Management-Delegating";
            Role                 = "View-Only Configuration";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment bed32f57-bd65-4324-b446-a8cb7d5eab10
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Unified Messaging-Organization Management-Delegating";
            Role                 = "Unified Messaging";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 67f2110a-cc20-4d50-b594-5018c2ccfd11
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "SensitivityLabelAdministrator-Security Administrator";
            Role                 = "SensitivityLabelAdministrator";
            SecurityGroup        = "Security Administrator";
        }
        EXOManagementRoleAssignment 5813d6e8-fc2d-4f3e-8a0a-965470d25a51
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyRetentionPolicies-Organization Management-Delegating";
            Role                 = "MyRetentionPolicies";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 7a34b403-3a5e-41ba-800d-0b36d52bc616
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Reader-Organization Management-Delegating";
            Role                 = "Security Reader";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1a8613d1-da98-43fc-874b-3156dc93e81f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyMailSubscriptions-Organization Management-Delegating";
            Role                 = "MyMailSubscriptions";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 26012bb0-3e58-4065-a618-0bd38048d793
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Rules-Organization Management-Delegating";
            Role                 = "Transport Rules";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment c1c18bd1-7f96-46f2-8ef8-1abeeb81884c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "TeamMailboxLifecycleApplication-Organization Management-Delegati";
            Role                 = "TeamMailboxLifecycleApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 6ac568d3-f83a-4d95-980a-43b29848162b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Journaling-Records Management";
            Role                 = "Journaling";
            SecurityGroup        = "Records Management";
        }
        EXOManagementRoleAssignment 10303e18-e422-40b7-b61b-26093c3b27c4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Unified Messaging-Organization Management";
            Role                 = "Unified Messaging";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b52fbc5a-1884-49cf-8b4a-006133a00ccc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Organization Configuration-Organization Management";
            Role                 = "Organization Configuration";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment f1886801-dfc6-4a10-aed8-1fc011d4c9a5
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyDistributionGroups-Organization Management-Delegating";
            Role                 = "MyDistributionGroups";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 29dee948-8aff-4f34-9114-eb04c2f343dc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Reset Password-Recipient Management";
            Role                 = "Reset Password";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 46260df4-4f5b-4b72-b375-d67dcb7f2fe6
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Organization Transport Settings-Organization Management-Delegati";
            Role                 = "Organization Transport Settings";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 4d988c06-0da5-4c19-b3d5-0e976105d282
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Hygiene-Organization Management-Delegating";
            Role                 = "Transport Hygiene";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment e606ccb0-1ddf-4399-a7d7-0b0a46bdee22
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "SendMailApplication-Organization Management-Delegating";
            Role                 = "SendMailApplication";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 371cf734-568b-42af-9314-6dd9ebae39b2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Remote and Accepted Domains-Organization Management";
            Role                 = "Remote and Accepted Domains";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment d722ff8e-a39e-4740-9f3b-8930a44dee4e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Organization Configuration-Organization Management-Delegating";
            Role                 = "Organization Configuration";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment fe8ab97b-74be-4b75-b240-b088bda0f0d8
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Audit Logs-Records Management";
            Role                 = "Audit Logs";
            SecurityGroup        = "Records Management";
        }
        EXOManagementRoleAssignment ae884c1c-6471-4ddc-9741-4934e63a29d7
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "TenantPlacesManagement-Organization Management";
            Role                 = "TenantPlacesManagement";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment a3905141-3e25-49b0-b68c-5a82888ac833
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Group Creation and Membership-Organization Management-D";
            Role                 = "Security Group Creation and Membership";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b3376a68-2b17-4802-b6d4-46d44f895202
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "User Options-Organization Management-Delegating";
            Role                 = "User Options";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 02ffeed2-e7e1-4825-9eb5-46a1bfb4ce10
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyProfileInformation-Organization Management-Delegating";
            Role                 = "MyProfileInformation";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1f5635e7-69af-4e6c-8ebe-0845e0730a17
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Reader-Organization Management";
            Role                 = "Security Reader";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1dcb44f4-1de1-4286-9169-cde287976fcc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Recipient Policies-Organization Management";
            Role                 = "Recipient Policies";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 0bc379db-c28b-485a-a4c6-ac40f2b71b08
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Rules-Organization Management";
            Role                 = "Transport Rules";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 89b17851-72c6-4a2a-bcfe-43c11ed03cf3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Audit Logs-Organization Management";
            Role                 = "View-Only Audit Logs";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 79c90a9d-30b9-4d7d-8e79-b94efd6f470c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Public Folders-Organization Management";
            Role                 = "Public Folders";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 4ac50a61-ac9d-4635-8a3a-6a76ad3e57ba
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UM Mailboxes-Organization Management";
            Role                 = "UM Mailboxes";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment aa9da405-f2fd-4eee-9224-d1f0c340bf15
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Message Tracking-Records Management";
            Role                 = "Message Tracking";
            SecurityGroup        = "Records Management";
        }
        EXOManagementRoleAssignment 0fca0c03-75f2-49ae-a331-12d8849ce84f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Retention Management-Organization Management";
            Role                 = "Retention Management";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 493d69dc-c671-4f78-9f4c-9725caae94b7
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Group Creation and Membership-Organization Management";
            Role                 = "Security Group Creation and Membership";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b78f0b65-dbf4-4a82-88dc-fe1d24d25563
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UM Prompts-Organization Management";
            Role                 = "UM Prompts";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment bc44b0cc-e3fa-4816-b0b6-d99af6bba7b2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Audit Logs-Organization Management-Delegating";
            Role                 = "View-Only Audit Logs";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 6996e588-cfc0-4b97-a062-c3ad4902dbeb
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "TenantPlacesManagement-Organization Management-Delegating";
            Role                 = "TenantPlacesManagement";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 1c97b2aa-6969-43b1-a18c-c324f8dc20ca
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Team Mailboxes-Organization Management-Delegating";
            Role                 = "Team Mailboxes";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 68647257-262b-46e1-9854-6a8e8542d195
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "SensitivityLabelAdministrator-Organization Management-Delegating";
            Role                 = "SensitivityLabelAdministrator";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 5340de06-eac3-4f7a-ae35-a640ce3dfb7e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Role Management-Organization Management";
            Role                 = "Role Management";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 217507d5-eaf8-43b8-b39b-84090550ad8c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Unified Messaging-UM Management";
            Role                 = "Unified Messaging";
            SecurityGroup        = "UM Management";
        }
        EXOManagementRoleAssignment 14e6ffa1-e3ae-4ec1-8eb7-e4b329ec54bc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Hygiene-Organization Management";
            Role                 = "Transport Hygiene";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 729046ff-ebc0-4634-b589-60575b27b7df
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Admin-Security Administrator";
            Role                 = "Security Admin";
            SecurityGroup        = "Security Administrator";
        }
        EXOManagementRoleAssignment 682e1c65-37ec-442d-8c82-4ab16a72139e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Retention Management-Organization Management-Delegating";
            Role                 = "Retention Management";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 191f5bdf-0603-42a1-aa70-1fb250728498
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Organization Transport Settings-Organization Management";
            Role                 = "Organization Transport Settings";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 2964e0a2-7e11-4e5f-884a-8dbc9511544e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Recipients-Organization Management";
            Role                 = "View-Only Recipients";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 74b5216c-79ac-43a8-834c-45d3b26ee0d6
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Recipients-View-Only Organization Management";
            Role                 = "View-Only Recipients";
            SecurityGroup        = "View-Only Organization Management";
        }
        EXOManagementRoleAssignment 748e78e1-f316-4d9f-8d26-641e96b6784b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyMailboxDelegation-Organization Management-Delegating";
            Role                 = "MyMailboxDelegation";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 4eca2f20-cdf4-4f53-88d3-bf17f8b2a886
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyBaseOptions-Organization Management-Delegating";
            Role                 = "MyBaseOptions";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment a4eec854-5553-4e61-91b6-4d9b4cea567b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Team Mailboxes-Recipient Management";
            Role                 = "Team Mailboxes";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment ccac6f09-ab8a-41e3-9759-b88c06be14d7
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Move Mailboxes-Recipient Management";
            Role                 = "Move Mailboxes";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 822be226-b66b-4d86-8bae-02d5c8a7c0c0
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Message Tracking-Recipient Management";
            Role                 = "Message Tracking";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 484d21b8-b759-496c-b0d3-c7b9a9f94bd3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Migration-Recipient Management";
            Role                 = "Migration";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 2ac3f161-0a8d-43c8-b828-e8144668672d
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Recipient Creation-Recipient Management";
            Role                 = "Mail Recipient Creation";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 17e65376-74af-4921-831e-a4edc4d8721b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Transport Rules-Records Management";
            Role                 = "Transport Rules";
            SecurityGroup        = "Records Management";
        }
        EXOManagementRoleAssignment 5e464c96-70b1-4b9c-9d1c-dcee07b61be2
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Mail Recipients-Recipient Management";
            Role                 = "Mail Recipients";
            SecurityGroup        = "Recipient Management";
        }
        EXOManagementRoleAssignment 082e8ce3-5175-4706-b7f6-7f85253dcc2d
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "My Marketplace Apps-Organization Management-Delegating";
            Role                 = "My Marketplace Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 9b60c98a-fd4a-4567-9883-809003146540
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UM Mailboxes-UM Management";
            Role                 = "UM Mailboxes";
            SecurityGroup        = "UM Management";
        }
        EXOManagementRoleAssignment b25281ef-c888-4838-9cef-05b8de7289dc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Remote and Accepted Domains-Organization Management-Delegating";
            Role                 = "Remote and Accepted Domains";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 486ac442-bf25-498d-915d-f4d97a219a44
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Reset Password-Organization Management";
            Role                 = "Reset Password";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 600ebcd6-2019-4bb5-aa99-8220d2f5102a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Configuration-Organization Management";
            Role                 = "View-Only Configuration";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment bac528c6-6c8e-45cc-ba7c-a7039ed5c0dc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Role Management-Organization Management-Delegating";
            Role                 = "Role Management";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 5b91c2a4-5fb4-468d-a855-e9d2f44e2594
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Organization Client Access-Organization Management";
            Role                 = "Organization Client Access";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment afbf33af-10ab-4b38-8876-3c185d4e67a1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Team Mailboxes-Organization Management";
            Role                 = "Team Mailboxes";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment eacba8d9-a646-44cf-a8b0-cd046077f01c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "View-Only Recipients-Organization Management-Delegating";
            Role                 = "View-Only Recipients";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment e337669b-4f95-40aa-adb9-6257418ebff7
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "User Options-Organization Management";
            Role                 = "User Options";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 986a981e-ee38-43d0-9e9e-027eee21dfe3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "MyDistributionGroupMembership-Organization Management-Delegating";
            Role                 = "MyDistributionGroupMembership";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment b128243e-8ffd-4222-87cf-b8ee5d43fd80
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "My ReadWriteMailbox Apps-Organization Management-Delegating";
            Role                 = "My ReadWriteMailbox Apps";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 73cb50ac-4b21-470c-807f-b3611f3dd4bf
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Public Folders-Organization Management-Delegating";
            Role                 = "Public Folders";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 2b02a240-f4a1-410e-bedf-234e1c9d083e
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UM Prompts-Organization Management-Delegating";
            Role                 = "UM Prompts";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment d8f11cdd-d2ff-4899-8c93-97fe0d1a53c1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Admin-Organization Management-Delegating";
            Role                 = "Security Admin";
            SecurityGroup        = "Organization Management";
        }
        EXOManagementRoleAssignment 237c7d4b-45b6-4212-b489-db5d5ae9143b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Security Reader-Security Reader";
            Role                 = "Security Reader";
            SecurityGroup        = "Security Reader";
        }
        EXOManagementRoleAssignment c55b76d7-ac1e-4b5f-9467-3f0357137a17
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "UM Mailboxes-Organization Management-Delegating";
            Role                 = "UM Mailboxes";
            SecurityGroup        = "Organization Management";
        }
        EXOMobileDeviceMailboxPolicy 119d63f9-7c64-452c-870d-7dee57a02855
        {
            AllowApplePushNotifications              = $True;
            AllowBluetooth                           = "Allow";
            AllowBrowser                             = $True;
            AllowCamera                              = $True;
            AllowConsumerEmail                       = $True;
            AllowDesktopSync                         = $True;
            AllowExternalDeviceManagement            = $False;
            AllowGooglePushNotifications             = $True;
            AllowHTMLEmail                           = $True;
            AllowInternetSharing                     = $True;
            AllowIrDA                                = $True;
            AllowMicrosoftPushNotifications          = $True;
            AllowMobileOTAUpdate                     = $True;
            AllowNonProvisionableDevices             = $True;
            AllowPOPIMAPEmail                        = $True;
            AllowRemoteDesktop                       = $True;
            AllowSimplePassword                      = $True;
            AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation";
            AllowSMIMESoftCerts                      = $True;
            AllowStorageCard                         = $True;
            AllowTextMessaging                       = $True;
            AllowUnsignedApplications                = $True;
            AllowUnsignedInstallationPackages        = $True;
            AllowWiFi                                = $True;
            AlphanumericPasswordRequired             = $False;
            ApprovedApplicationList                  = @();
            AttachmentsEnabled                       = $True;
            Credential                               = $Credscredential;
            DeviceEncryptionEnabled                  = $False;
            DevicePolicyRefreshInterval              = "Unlimited";
            Ensure                                   = "Present";
            IrmEnabled                               = $True;
            IsDefault                                = $True;
            MaxAttachmentSize                        = "Unlimited";
            MaxCalendarAgeFilter                     = "All";
            MaxEmailAgeFilter                        = "All";
            MaxEmailBodyTruncationSize               = "Unlimited";
            MaxEmailHTMLBodyTruncationSize           = "Unlimited";
            MaxInactivityTimeLock                    = "Unlimited";
            MaxPasswordFailedAttempts                = "Unlimited";
            MinPasswordComplexCharacters             = 1;
            Name                                     = "Default";
            PasswordEnabled                          = $False;
            PasswordExpiration                       = "Unlimited";
            PasswordHistory                          = 0;
            PasswordRecoveryEnabled                  = $False;
            RequireDeviceEncryption                  = $False;
            RequireEncryptedSMIMEMessages            = $False;
            RequireEncryptionSMIMEAlgorithm          = "TripleDES";
            RequireManualSyncWhenRoaming             = $False;
            RequireSignedSMIMEAlgorithm              = "SHA1";
            RequireSignedSMIMEMessages               = $False;
            RequireStorageCardEncryption             = $False;
            UnapprovedInROMApplicationList           = @();
            UNCAccessEnabled                         = $True;
            WSSAccessEnabled                         = $True;
        }
        EXOOMEConfiguration 7a4697cc-426c-475a-8754-4f89fd6c02f4
        {
            BackgroundColor      = "";
            Credential           = $Credscredential;
            DisclaimerText       = "";
            EmailText            = "";
            Ensure               = "Present";
            Identity             = "OME Configuration";
            IntroductionText     = "";
            OTPEnabled           = $True;
            PortalText           = "";
            PrivacyStatementUrl  = "";
            ReadButtonText       = "";
            SocialIdSignIn       = $True;
        }
        EXOOrganizationConfig aa49cd62-b939-48aa-9624-b123427f2b6d
        {
            ActivityBasedAuthenticationTimeoutEnabled                 = $True;
            ActivityBasedAuthenticationTimeoutInterval                = "06:00:00";
            ActivityBasedAuthenticationTimeoutWithSingleSignOnEnabled = $True;
            AppsForOfficeEnabled                                      = $True;
            AsyncSendEnabled                                          = $True;
            AuditDisabled                                             = $False;
            AutodiscoverPartialDirSync                                = $False;
            AutoExpandingArchive                                      = $False;
            BlockMoveMessagesForGroupFolders                          = $False;
            BookingsAddressEntryRestricted                            = $False;
            BookingsAuthEnabled                                       = $False;
            BookingsBlockedWordsEnabled                               = $False;
            BookingsCreationOfCustomQuestionsRestricted               = $False;
            BookingsEnabled                                           = $True;
            BookingsExposureOfStaffDetailsRestricted                  = $False;
            BookingsMembershipApprovalRequired                        = $False;
            BookingsNamingPolicyEnabled                               = $False;
            BookingsNamingPolicyPrefix                                = "";
            BookingsNamingPolicyPrefixEnabled                         = $False;
            BookingsNamingPolicySuffix                                = "";
            BookingsNamingPolicySuffixEnabled                         = $False;
            BookingsNotesEntryRestricted                              = $False;
            BookingsPaymentsEnabled                                   = $False;
            BookingsPhoneNumberEntryRestricted                        = $False;
            BookingsSearchEngineIndexDisabled                         = $False;
            BookingsSmsMicrosoftEnabled                               = $True;
            BookingsSocialSharingRestricted                           = $False;
            ByteEncoderTypeFor7BitCharsets                            = 0;
            ComplianceMLBgdCrawlEnabled                               = $False;
            ConnectorsActionableMessagesEnabled                       = $True;
            ConnectorsEnabled                                         = $True;
            ConnectorsEnabledForOutlook                               = $True;
            ConnectorsEnabledForSharepoint                            = $True;
            ConnectorsEnabledForTeams                                 = $True;
            ConnectorsEnabledForYammer                                = $True;
            Credential                                                = $Credscredential;
            CustomerLockboxEnabled                                    = $False;
            DefaultGroupAccessType                                    = "Private";
            DefaultMinutesToReduceLongEventsBy                        = 10;
            DefaultMinutesToReduceShortEventsBy                       = 5;
            DefaultPublicFolderDeletedItemRetention                   = "30.00:00:00";
            DefaultPublicFolderIssueWarningQuota                      = "1.7 GB (1,825,361,920 bytes)";
            DefaultPublicFolderMaxItemSize                            = "Unlimited";
            DefaultPublicFolderMovedItemRetention                     = "7.00:00:00";
            DefaultPublicFolderProhibitPostQuota                      = "2 GB (2,147,483,648 bytes)";
            DirectReportsGroupAutoCreationEnabled                     = $False;
            DisablePlusAddressInRecipients                            = $False;
            DistributionGroupNameBlockedWordsList                     = @();
            DistributionGroupNamingPolicy                             = "";
            ElcProcessingDisabled                                     = $False;
            EnableOutlookEvents                                       = $False;
            EndUserDLUpgradeFlowsDisabled                             = $False;
            ExchangeNotificationEnabled                               = $True;
            ExchangeNotificationRecipients                            = @();
            FindTimeAttendeeAuthenticationEnabled                     = $False;
            FindTimeAutoScheduleDisabled                              = $False;
            FindTimeLockPollForAttendeesEnabled                       = $False;
            FindTimeOnlineMeetingOptionDisabled                       = $False;
            IPListBlocked                                             = @();
            IsGroupFoldersAndRulesEnabled                             = $False;
            IsGroupMemberAllowedToEditContent                         = $False;
            IsSingleInstance                                          = "Yes";
            LeanPopoutEnabled                                         = $False;
            LinkPreviewEnabled                                        = $True;
            MailTipsAllTipsEnabled                                    = $True;
            MailTipsExternalRecipientsTipsEnabled                     = $False;
            MailTipsGroupMetricsEnabled                               = $True;
            MailTipsLargeAudienceThreshold                            = 25;
            MailTipsMailboxSourcedTipsEnabled                         = $True;
            MaskClientIpInReceivedHeadersEnabled                      = $True;
            MatchSenderOrganizerProperties                            = $False;
            MessageHighlightsEnabled                                  = $True;
            MessageRemindersEnabled                                   = $True;
            MobileAppEducationEnabled                                 = $True;
            OAuth2ClientProfileEnabled                                = $True;
            OutlookGifPickerDisabled                                  = $False;
            OutlookMobileGCCRestrictionsEnabled                       = $False;
            OutlookPayEnabled                                         = $True;
            OutlookTextPredictionDisabled                             = $False;
            PublicComputersDetectionEnabled                           = $False;
            PublicFoldersEnabled                                      = "Local";
            PublicFolderShowClientControl                             = $False;
            ReadTrackingEnabled                                       = $False;
            RemotePublicFolderMailboxes                               = @();
            SendFromAliasEnabled                                      = $False;
            SharedDomainEmailAddressFlowEnabled                       = $True;
            ShortenEventScopeDefault                                  = "None";
            SmtpActionableMessagesEnabled                             = $True;
            VisibleMeetingUpdateProperties                            = "Location,AllProperties:15";
            WebPushNotificationsDisabled                              = $False;
            WebSuggestedRepliesDisabled                               = $False;
            WorkspaceTenantEnabled                                    = $True;
        }
        EXOOwaMailboxPolicy a16f506d-c7ea-4e1f-94b7-41ce479855de
        {
            ActionForUnknownFileAndMIMETypes                     = "Allow";
            ActiveSyncIntegrationEnabled                         = $True;
            AdditionalStorageProvidersAvailable                  = $True;
            AllAddressListsEnabled                               = $True;
            AllowCopyContactsToDeviceAddressBook                 = $True;
            AllowedFileTypes                                     = @(".rpmsg",".xlsx",".xlsm",".xlsb",".vstx",".vstm",".vssx",".vssm",".vsdx",".vsdm",".tiff",".pptx",".pptm",".ppsx",".ppsm",".docx",".docm",".zip",".xls",".wmv",".wma",".wav",".vtx",".vsx",".vst",".vss",".vsd",".vdx",".txt",".tif",".rtf",".pub",".ppt",".png",".pdf",".one",".mp3",".jpg",".gif",".doc",".csv",".bmp",".avi");
            AllowedMimeTypes                                     = @("image/jpeg","image/png","image/gif","image/bmp");
            BlockedFileTypes                                     = @(".settingcontent-ms",".printerexport",".appcontent-ms",".application",".appref-ms",".vsmacros",".website",".msh2xml",".msh1xml",".diagcab",".webpnp",".ps2xml",".ps1xml",".mshxml",".gadget",".theme",".psdm1",".mhtml",".cdxml",".xbap",".vhdx",".pyzw",".pssc",".psd1",".psc2",".psc1",".msh2",".msh1",".jnlp",".aspx",".appx",".xnk",".xll",".wsh",".wsf",".wsc",".wsb",".vsw",".vhd",".vbs",".vbp",".vbe",".url",".udl",".tmp",".shs",".shb",".sct",".scr",".scf",".reg",".pyz",".pyw",".pyo",".pyc",".pst",".ps2",".ps1",".prg",".prf",".plg",".pif",".pcd",".osd",".ops",".msu",".mst",".msp",".msi",".msh",".msc",".mht",".mdz",".mdw",".mdt",".mde",".mdb",".mda",".mcf",".maw",".mav",".mau",".mat",".mas",".mar",".maq",".mam",".mag",".maf",".mad",".lnk",".ksh",".jse",".jar",".its",".isp",".iso",".ins",".inf",".img",".htc",".hta",".hpj",".hlp",".grp",".fxp",".exe",".der",".csh",".crt",".cpl",".com",".cnt",".cmd",".chm",".cer",".cab",".bgi",".bat",".bas",".asx",".asp",".app",".apk",".adp",".ade",".ws",".vb",".py",".pl",".js");
            BlockedMimeTypes                                     = @("application/x-javascript","application/javascript","application/msaccess","x-internet-signup","text/javascript","application/prg","application/hta","text/scriplet");
            BookingsMailboxCreationEnabled                       = $True;
            ClassicAttachmentsEnabled                            = $True;
            ConditionalAccessPolicy                              = "Off";
            Credential                                           = $Credscredential;
            DefaultTheme                                         = "";
            DirectFileAccessOnPrivateComputersEnabled            = $True;
            DirectFileAccessOnPublicComputersEnabled             = $True;
            DisplayPhotosEnabled                                 = $True;
            Ensure                                               = "Present";
            ExplicitLogonEnabled                                 = $True;
            ExternalImageProxyEnabled                            = $True;
            FeedbackEnabled                                      = $True;
            ForceSaveAttachmentFilteringEnabled                  = $False;
            ForceSaveFileTypes                                   = @(".svgz",".html",".xml",".swf",".svg",".spl",".htm",".dir",".dcr");
            ForceSaveMimeTypes                                   = @("Application/x-shockwave-flash","Application/octet-stream","Application/futuresplash","Application/x-director","application/xml","image/svg+xml","text/html","text/xml");
            ForceWacViewingFirstOnPrivateComputers               = $False;
            ForceWacViewingFirstOnPublicComputers                = $False;
            FreCardsEnabled                                      = $True;
            GlobalAddressListEnabled                             = $True;
            GroupCreationEnabled                                 = $True;
            InstantMessagingEnabled                              = $True;
            InstantMessagingType                                 = "Ocs";
            InterestingCalendarsEnabled                          = $True;
            IRMEnabled                                           = $True;
            IsDefault                                            = $True;
            JournalEnabled                                       = $True;
            LocalEventsEnabled                                   = $False;
            LogonAndErrorLanguage                                = 0;
            MessagePreviewsDisabled                              = $False;
            Name                                                 = "OwaMailboxPolicy-Default";
            NotesEnabled                                         = $True;
            NpsSurveysEnabled                                    = $True;
            OnSendAddinsEnabled                                  = $False;
            OrganizationEnabled                                  = $True;
            OutboundCharset                                      = "AutoDetect";
            OutlookBetaToggleEnabled                             = $True;
            OWALightEnabled                                      = $True;
            PersonalAccountCalendarsEnabled                      = $True;
            PhoneticSupportEnabled                               = $False;
            PlacesEnabled                                        = $True;
            PremiumClientEnabled                                 = $True;
            PrintWithoutDownloadEnabled                          = $True;
            ProjectMocaEnabled                                   = $False;
            PublicFoldersEnabled                                 = $True;
            RecoverDeletedItemsEnabled                           = $True;
            ReferenceAttachmentsEnabled                          = $True;
            RemindersAndNotificationsEnabled                     = $True;
            ReportJunkEmailEnabled                               = $True;
            RulesEnabled                                         = $True;
            SatisfactionEnabled                                  = $True;
            SaveAttachmentsToCloudEnabled                        = $True;
            SearchFoldersEnabled                                 = $True;
            SetPhotoEnabled                                      = $True;
            SetPhotoURL                                          = "";
            ShowOnlineArchiveEnabled                             = $True;
            SignaturesEnabled                                    = $True;
            SkipCreateUnifiedGroupCustomSharepointClassification = $True;
            TeamSnapCalendarsEnabled                             = $True;
            TextMessagingEnabled                                 = $True;
            ThemeSelectionEnabled                                = $True;
            UMIntegrationEnabled                                 = $True;
            UseGB18030                                           = $False;
            UseISO885915                                         = $False;
            UserVoiceEnabled                                     = $True;
            WacEditingEnabled                                    = $True;
            WacExternalServicesEnabled                           = $True;
            WacOMEXEnabled                                       = $False;
            WacViewingOnPrivateComputersEnabled                  = $True;
            WacViewingOnPublicComputersEnabled                   = $True;
            WeatherEnabled                                       = $True;
            WebPartsFrameOptionsType                             = "SameOrigin";
        }
        EXOPerimeterConfiguration 1e8dee99-417e-4817-a05a-f154d53665df
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            GatewayIPAddresses   = @();
            Identity             = "Tenant Perimeter Settings";
        }
        EXOQuarantinePolicy 3fe32d21-5613-4674-93da-45aeaaefe254
        {
            Credential                        = $Credscredential;
            EndUserQuarantinePermissionsValue = 87;
            Ensure                            = "Present";
            ESNEnabled                        = $False;
            Identity                          = "dmcsandbox.onmicrosoft.com\DefaultFullAccessPolicy";
        }
        EXOQuarantinePolicy 5a1df525-8ec7-4021-8cbe-e1dc0e5aae15
        {
            Credential                        = $Credscredential;
            EndUserQuarantinePermissionsValue = 0;
            Ensure                            = "Present";
            ESNEnabled                        = $False;
            Identity                          = "dmcsandbox.onmicrosoft.com\AdminOnlyAccessPolicy";
        }
        EXORemoteDomain 89762023-9ef5-458a-8063-3e423d89c45b
        {
            AllowedOOFType                       = "External";
            AutoForwardEnabled                   = $True;
            AutoReplyEnabled                     = $True;
            ByteEncoderTypeFor7BitCharsets       = "Undefined";
            CharacterSet                         = "iso-8859-1";
            ContentType                          = "MimeHtmlText";
            Credential                           = $Credscredential;
            DeliveryReportEnabled                = $True;
            DisplaySenderName                    = $True;
            DomainName                           = "*";
            Ensure                               = "Present";
            Identity                             = "Default";
            IsInternal                           = $False;
            LineWrapSize                         = "Unlimited";
            MeetingForwardNotificationEnabled    = $False;
            Name                                 = "Default";
            NDREnabled                           = $True;
            NonMimeCharacterSet                  = "iso-8859-1";
            PreferredInternetCodePageForShiftJis = "Undefined";
            TargetDeliveryDomain                 = $False;
            TrustedMailInboundEnabled            = $False;
            TrustedMailOutboundEnabled           = $False;
            UseSimpleDisplayName                 = $False;
        }
        EXOResourceConfiguration be339d2f-49c6-40ab-9f4c-f287ec8fc0a1
        {
            Credential             = $Credscredential;
            Ensure                 = "Present";
            Identity               = "Resource Schema";
            ResourcePropertySchema = @();
        }
        EXORoleAssignmentPolicy 1dabb34e-bfb3-4191-9656-ead58cf691f4
        {
            Credential           = $Credscredential;
            Description          = "This policy grants end users the permission to set their options in Outlook on the web and perform other self-administration tasks.";
            Ensure               = "Present";
            IsDefault            = $True;
            Name                 = "Default Role Assignment Policy";
            Roles                = @("MyVoiceMail","MyTextMessaging","My Custom Apps","MyDistributionGroups","MyDistributionGroupMembership","MyContactInformation","MyBaseOptions","MyProfileInformation","My Marketplace Apps","MyMailSubscriptions","My ReadWriteMailbox Apps","MyRetentionPolicies");
        }
        EXOSafeAttachmentPolicy ac220f44-0b14-458d-81ba-f375aff803bd
        {
            Action               = "Block";
            ActionOnError        = $True;
            AdminDisplayName     = "";
            Credential           = $Credscredential;
            Enable               = $True;
            Ensure               = "Present";
            Identity             = "Built-In Protection Policy";
            QuarantineTag        = "AdminOnlyAccessPolicy";
            Redirect             = $False;
            RedirectAddress      = "";
        }
        EXOSafeLinksPolicy bb6bb1cd-a478-4b1a-95a5-8d0309a5cbee
        {
            AdminDisplayName           = "";
            AllowClickThrough          = $True;
            Credential                 = $Credscredential;
            CustomNotificationText     = "";
            DeliverMessageAfterScan    = $True;
            DisableUrlRewrite          = $True;
            DoNotRewriteUrls           = @();
            EnableForInternalSenders   = $False;
            EnableOrganizationBranding = $False;
            EnableSafeLinksForEmail    = $True;
            EnableSafeLinksForOffice   = $True;
            EnableSafeLinksForTeams    = $True;
            Ensure                     = "Present";
            Identity                   = "Built-In Protection Policy";
            ScanUrls                   = $True;
            TrackClicks                = $True;
        }
        EXOSharedMailbox b9831d3a-1b96-4a75-b9b1-7a1e6dedfdcc
        {
            Alias                = "sandboxsharedmailbox";
            Credential           = $Credscredential;
            DisplayName          = "Sandbox Shared Mailbox";
            EmailAddresses       = @("sandboxsharedmailbox@arnif.org");
            Ensure               = "Present";
            PrimarySMTPAddress   = "sandboxsharedmailbox@dmcsandbox.onmicrosoft.com";
        }
        EXOSharedMailbox ff5b6723-f189-4bbb-ae79-1026c98bb382
        {
            Alias                = "theothersharedmailbox";
            Credential           = $Credscredential;
            DisplayName          = "The Other Shared Mailbox";
            EmailAddresses       = @();
            Ensure               = "Present";
            PrimarySMTPAddress   = "theothersharedmailbox@dmcsandbox.onmicrosoft.com";
        }
        EXOSharingPolicy 0bafcc21-3123-482a-b5fd-472b5da9270d
        {
            Credential           = $Credscredential;
            Default              = $True;
            Domains              = @("Anonymous:CalendarSharingFreeBusyReviewer","*:CalendarSharingFreeBusySimple");
            Enabled              = $True;
            Ensure               = "Present";
            Name                 = "Default Sharing Policy";
        }
        EXOTransportConfig dded6538-415e-4c16-bad1-68ebe92913d9
        {
            AddressBookPolicyRoutingEnabled         = $False;
            ClearCategories                         = $True;
            ConvertDisclaimerWrapperToEml           = $False;
            Credential                              = $Credscredential;
            DSNConversionMode                       = "PreserveDSNBody";
            ExternalDelayDsnEnabled                 = $True;
            ExternalDsnLanguageDetectionEnabled     = $True;
            ExternalDsnSendHtml                     = $True;
            HeaderPromotionModeSetting              = "NoCreate";
            InternalDelayDsnEnabled                 = $True;
            InternalDsnLanguageDetectionEnabled     = $True;
            InternalDsnSendHtml                     = $True;
            IsSingleInstance                        = "Yes";
            JournalingReportNdrTo                   = "<>";
            JournalMessageExpirationDays            = 0;
            MaxRecipientEnvelopeLimit               = "Unlimited";
            ReplyAllStormBlockDurationHours         = 6;
            ReplyAllStormDetectionMinimumRecipients = 2500;
            ReplyAllStormDetectionMinimumReplies    = 10;
            ReplyAllStormProtectionEnabled          = $True;
            Rfc2231EncodingEnabled                  = $False;
            SmtpClientAuthenticationDisabled        = $True;
        }
        EXOTransportRule 867d4689-8d85-4cdf-ba88-395d73758102
        {
            ApplyOME                                  = $False;
            AttachmentHasExecutableContent            = $False;
            AttachmentIsPasswordProtected             = $False;
            AttachmentIsUnsupported                   = $False;
            AttachmentProcessingLimitExceeded         = $False;
            Comments                                  = "Block outbound emails to avoid misuse. We can set up exceptions if necessary.
";
            Credential                                = $Credscredential;
            DeleteMessage                             = $False;
            Ensure                                    = "Present";
            ExceptIfAttachmentHasExecutableContent    = $False;
            ExceptIfAttachmentIsPasswordProtected     = $False;
            ExceptIfAttachmentIsUnsupported           = $False;
            ExceptIfAttachmentProcessingLimitExceeded = $False;
            ExceptIfHasNoClassification               = $False;
            ExceptIfHasSenderOverride                 = $False;
            ExceptIfSentToScope                       = "InOrganization";
            FromScope                                 = "InOrganization";
            HasNoClassification                       = $False;
            HasSenderOverride                         = $False;
            Mode                                      = "Enforce";
            ModerateMessageByManager                  = $False;
            Name                                      = "Block External Outbound";
            Priority                                  = 0;
            Quarantine                                = $False;
            RecipientAddressType                      = "Resolved";
            RejectMessageEnhancedStatusCode           = "5.7.1";
            RejectMessageReasonText                   = "Outbound Email Denied: Sandbox Tenant Only";
            RemoveOME                                 = $False;
            RemoveOMEv2                               = $False;
            RemoveRMSAttachmentEncryption             = $False;
            RouteMessageOutboundRequireTls            = $False;
            RuleErrorAction                           = "Ignore";
            RuleSubType                               = "None";
            SenderAddressLocation                     = "Header";
            SetAuditSeverity                          = "High";
            StopRuleProcessing                        = $False;
        }
    }
}

M365TenantConfig -ConfigurationData .\ConfigurationData.psd1 -Credential $Credential
