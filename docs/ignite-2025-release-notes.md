---
title: Microsoft Entra Updates for Ignite 2025
description: Comprehensive overview of new features and capabilities announced at Microsoft Ignite 2025 across the Microsoft Entra portfolio.
ms.service: entra
ms.topic: whats-new
ms.date: 11/06/2025
ms.author: dougeby
author: dougeby
manager: dougeby
ms.reviewer: 
---

# Microsoft Entra Updates for Ignite 2025

Microsoft Ignite 2025 brings significant new capabilities across the Microsoft Entra portfolio, enabling organizations to secure their AI agents, enhance identity governance, strengthen authentication, and protect access to resources. This article summarizes all the major updates and new features announced at Ignite 2025.

---

## Microsoft Entra Agent ID

Microsoft Entra Agent ID introduces first-class identity constructs specifically designed for AI agents, enabling organizations to securely deploy and manage autonomous AI systems at scale.

### Overview

Agent identities (Agent IDs) provide unique identification and authentication capabilities for AI agents, addressing critical security challenges such as distinguishing AI agent operations from human activities, enabling right-sized access, preventing unauthorized access to critical systems, and scaling identity management for large numbers of agents. This foundational documentation helps organizations understand the architecture and capabilities of Agent ID.

- [**What are agent identities?**](agent-id/identity-platform/what-is-agent-id.md) (New)
- [**What is the Microsoft Entra Agent ID platform?**](agent-id/identity-platform/what-is-agent-id-platform.md) (New)
- [**What is the agent registry?**](agent-id/identity-platform/what-is-agent-registry.md) (New)
- [**Key concepts for Agent ID**](agent-id/identity-platform/key-concepts.md) (New)
- [**Microsoft Entra agent identities for AI agents**](agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents.md) (New)
- [**Security for AI with Microsoft Entra agent identity**](agent-id/identity-professional/security-for-ai.md) (New)

### Agent Identity Management

Comprehensive guidance for creating, managing, and organizing agent identities at scale. Agent blueprints serve as reusable templates that ensure consistent security policies across multiple agent instances, while the registry and collections provide organizational structures for managing large numbers of agents. This section covers the full lifecycle of agent identity management from creation to deletion.

- [**Agent blueprints**](agent-id/identity-platform/agent-blueprint.md) (New)
- [**Agent service principals**](agent-id/identity-platform/agent-service-principals.md) (New)
- [**Agent users**](agent-id/identity-platform/agent-users.md) (New)
- [**Agent owners, sponsors, and managers**](agent-id/identity-platform/agent-owners-sponsors-managers.md) (New)
- [**Agent registry and collections**](agent-id/identity-platform/agent-registry-collections.md) (New)
- [**Agent metadata and discoverability**](agent-id/identity-platform/agent-metadata-discoverability.md) (New)
- [**Create and delete agent identities**](agent-id/identity-platform/create-delete-agent-identities.md) (New)
- [**Create a blueprint**](agent-id/identity-platform/create-blueprint.md) (New)

### Agent Authentication and Authorization

Detailed implementation guides for the three main OAuth flows that enable agents to authenticate and obtain access tokens. Autonomous agents can operate independently, interactive agents can act on behalf of users with their consent, and agent users provide compatibility with systems requiring user accounts. These flows ensure agents have the right level of access while maintaining security and auditability.

- [**Agent OAuth protocols**](agent-id/identity-platform/agent-oauth-protocols.md) (New)
- [**Agent autonomous app OAuth flow**](agent-id/identity-platform/agent-autonomous-app-oauth-flow.md) (New)
- [**Agent on-behalf-of OAuth flow**](agent-id/identity-platform/agent-on-behalf-of-oauth-flow.md) (New)
- [**Agent user OAuth flow**](agent-id/identity-platform/agent-user-oauth-flow.md) (New)
- [**Agent token claims**](agent-id/identity-platform/agent-token-claims.md) (New)
- [**Autonomous agent request tokens**](agent-id/identity-platform/autonomous-agent-request-tokens.md) (New)
- [**Autonomous agent request agent user tokens**](agent-id/identity-platform/autonomous-agent-request-agent-user-tokens.md) (New)
- [**Autonomous agent request authorization from Entra admin**](agent-id/identity-platform/autonomous-agent-request-authorization-entra-admin.md) (New)
- [**Interactive agent authenticate user**](agent-id/identity-platform/interactive-agent-authenticate-user.md) (New)
- [**Interactive agent request user authorization**](agent-id/identity-platform/interactive-agent-request-user-authorization.md) (New)
- [**Interactive agent request admin authorization**](agent-id/identity-platform/interactive-agent-request-admin-authorization.md) (New)
- [**Interactive agent request user tokens**](agent-id/identity-platform/interactive-agent-request-user-tokens.md) (New)

### Agent Governance

Comprehensive governance capabilities that enable organizations to control agent creation, manage access, and maintain oversight of agent activities. Integration with Entra ID Governance allows agents to be included in access packages and entitlement management, while audit logs provide full visibility into agent operations. Organizations can define inheritable permissions through blueprints and manage agents that operate without dedicated identities.

- [**Agent ID creation channels**](agent-id/identity-professional/agent-id-creation-channels.md) (New)
- [**Control user access to agents**](agent-id/identity-professional/control-user-access-agents.md) (New)
- [**Agent access packages**](agent-id/identity-professional/agent-access-packages.md) (New)
- [**Grant agent access to Microsoft 365**](agent-id/identity-professional/grant-agent-access-microsoft-365.md) (New)
- [**Configure inheritable permissions for blueprints**](agent-id/identity-professional/configure-inheritable-permissions-blueprints.md) (New)
- [**Manage agents without identity**](agent-id/identity-professional/manage-agents-without-identity.md) (New)
- [**Sign-in and audit logs for agents**](agent-id/identity-professional/sign-in-audit-logs-agents.md) (New)

### Role-Based Access Control for Agents

New specialized roles for managing agent identities and the agent registry. These roles enable delegation of agent management responsibilities while following least-privilege principles. Agent ID Administrators can manage all aspects of agent identities, Agent ID Developers can create and configure agents for development purposes, and Agent Registry Administrators control the central registry of agent blueprints.

- [**Agent ID Administrator role**](identity/role-based-access-control/includes/agent-id-administrator.md) (New)
- [**Agent ID Developer role**](identity/role-based-access-control/includes/agent-id-developer.md) (New)
- [**Agent Registry Administrator role**](identity/role-based-access-control/includes/agent-registry-administrator.md) (New)
- [**Permissions reference updates**](identity/role-based-access-control/permissions-reference.md) (Updated)

---

## Microsoft Entra Suite

### Microsoft Entra ID Governance

Microsoft Entra ID Governance continues to evolve with new capabilities for lifecycle management, access governance, and privileged identity management.

#### Lifecycle Workflows

Lifecycle Workflows introduces powerful new delegation and triggering capabilities that enable more flexible and scalable automation of user lifecycle processes. Delegated workflow management allows organizations to assign workflow administration to specific teams using Administrative Units, reducing the burden on central IT while maintaining security. Custom attribute triggers enable workflows to respond to changes in custom security attributes, directory extensions, and other specialized attributes, expanding automation possibilities beyond standard user properties.

- [**Delegated workflow management (Preview)**](id-governance/manage-delegate-workflow.md) (New) - Scope workflow management using Administrative Units, enabling granular delegation of workflow administration to specific teams or departments.
- [**Custom attribute triggers in lifecycle workflows (Preview)**](id-governance/workflow-custom-triggers.md) (New) - Trigger workflows based on custom security attributes, directory extension attributes, on-premises extension attributes (1-15), and EmployeeOrgData attributes for more flexible automation.
- [**Lifecycle workflow execution conditions updates**](id-governance/lifecycle-workflow-execution-conditions.md) (Updated) - Enhanced execution conditions and scheduling capabilities.
- [**Lifecycle workflow tasks updates**](id-governance/lifecycle-workflow-tasks.md) (Updated) - New tasks and improved task management capabilities.
- [**Create lifecycle workflow updates**](id-governance/create-lifecycle-workflow.md) (Updated) - Streamlined workflow creation process with new options.
- [**Manage workflow properties**](id-governance/manage-workflow-properties.md) (Updated) - Enhanced property management for workflows.
- [**Lifecycle workflow inactive users**](id-governance/lifecycle-workflow-inactive-users.md) (Updated) - Improved handling of inactive user scenarios.

#### Entitlement Management

Enhancements to entitlement management provide more sophisticated access governance capabilities, with improved eligibility management and dynamic approval workflows that adapt to organizational needs.

- [**Access package eligible updates**](id-governance/entitlement-management-access-package-eligible.md) (Updated) - Enhanced eligibility management for access packages.
- [**Dynamic approval in entitlement management**](id-governance/entitlement-management-dynamic-approval.md) (Updated) - Improved dynamic approval workflows.

#### Governance and Compliance

Updated governance service limits and clarified licensing ensure organizations can plan their governance implementations effectively while understanding capacity constraints and licensing requirements.

- [**Governance service limits**](id-governance/governance-service-limits.md) (Updated) - Updated service limits and quotas.
- [**Microsoft Entra ID Governance licensing for guest users**](id-governance/microsoft-entra-id-governance-licensing-for-guest-users.md) (Updated) - Clarified licensing requirements.
- [**Privileged Identity Management APIs**](id-governance/privileged-identity-management/pim-apis.md) (Updated) - Enhanced API capabilities.

### Microsoft Entra Internet Access

Microsoft Entra Internet Access provides secure access to internet and SaaS applications with enhanced threat protection.

#### Transport Layer Security (TLS) Inspection

TLS inspection capabilities enable organizations to decrypt and inspect encrypted traffic for threats while maintaining user privacy and compliance. The new two-tier certificate model simplifies certificate management, while context-aware policies allow organizations to apply different inspection rules based on user, device, location, and destination. Custom rules provide flexibility to exclude sensitive sites or apply stricter inspection to high-risk destinations.

- [**Configure Transport Layer Security inspection settings (Preview)**](global-secure-access/how-to-transport-layer-security-settings.md) (New) - Configure TLS inspection certificate authority settings using a two-tier intermediate certificate model for decrypting traffic.
- [**Configure Transport Layer Security inspection policy**](global-secure-access/how-to-transport-layer-security.md) (Updated) - Create and manage context-aware TLS inspection policies with custom rules for different scenarios.

#### Connectivity and Access

Enhanced connector capabilities improve the reliability and performance of private network access, while universal continuous access evaluation provides real-time enforcement of security policies across all connections.

- [**Private network connectors**](global-secure-access/concept-connectors.md) (Updated) - Enhanced private network connector capabilities.
- [**Connector groups**](global-secure-access/concept-connector-groups.md) (Updated) - Improved connector group management.
- [**Universal continuous access evaluation**](global-secure-access/concept-universal-continuous-access-evaluation.md) (Updated) - Enhanced continuous access evaluation capabilities.

#### Partner Ecosystem and Compliance

Expanded partner integrations and updated compliance certifications demonstrate Microsoft's commitment to interoperability and meeting regulatory requirements. The removal of macOS limitations for Netskope coexistence expands deployment options for organizations with diverse device fleets.

- [**Partner ecosystems overview**](global-secure-access/partner-ecosystems-overview.md) (Updated) - Updated partner integration capabilities.
- [**Global Secure Access certifications**](global-secure-access/reference-global-secure-access-certifications.md) (Updated) - Latest certification and compliance information.
- [**Netskope coexistence**](global-secure-access/how-to-netskope-coexistence.md) (Updated) - Removed macOS limitations for Netskope integration.

#### Multi-Geo Support

Multi-geo capabilities have been updated to reflect current regional availability, ensuring documentation accurately represents supported deployment options.

- [**Enable multi-geo capabilities**](global-secure-access/how-to-enable-multi-geo.md) (Updated) - Removed Japan region instructions for multi-geo configuration.

### Microsoft Entra ID Protection

Microsoft Entra ID Protection now extends risk detection and protection capabilities to AI agents and provides enhanced threat analysis tools.

#### ID Protection for Agents

ID Protection for agents brings the same risk-based protection capabilities that safeguard user identities to AI agents. The system establishes behavioral baselines for each agent and detects anomalies such as unfamiliar resource access, unusual sign-in patterns, failed access attempts, and activity associated with compromised users. Risk-based Conditional Access policies can automatically block risky agents, preventing potential security incidents before they escalate.

- [**ID Protection for agents**](id-protection/concept-risky-agents.md) (New) - Automatically detect and respond to identity-based risks on agents using Microsoft Entra Agent ID platform, including unfamiliar resource access, sign-in spikes, failed access attempts, and sign-ins by risky users.

#### Enhanced Risk Reporting

New and improved risk reports provide security teams with better visibility into identity threats, with enhanced visualizations and analytics that help prioritize investigation and response efforts.

- [**Risky user report**](id-protection/concept-risky-user-report.md) (New) - Comprehensive risky user reporting with improved visualizations and analytics.
- [**Risk reports updates**](id-protection/concept-risk-reports.md) (Updated) - Enhanced risk reporting capabilities.

#### Threat Analysis and Investigation

The comprehensive ID Protection analysis guide provides security teams with advanced techniques for investigating identity threats using KQL queries, Microsoft Sentinel integration, and advanced hunting capabilities. This guide helps organizations move beyond basic risk alerts to deep threat analysis and proactive threat hunting.

- [**ID Protection Guide: Analyze**](architecture/id-protection-guide-analyze.md) (New) - Comprehensive guide for analyzing identity protection signals and threats using advanced analytics and KQL queries.
- [**ID Protection Guide: Introduction**](architecture/id-protection-guide-introduction.md) (Updated) - Updated introduction to ID Protection capabilities.
- [**ID Protection Guide: Detect**](architecture/id-protection-guide-detect.md) (Updated) - Enhanced detection methodologies.
- [**ID Protection Guide: Investigate**](architecture/id-protection-guide-investigate.md) (Updated) - Improved investigation workflows.
- [**ID Protection Guide: Remediate**](architecture/id-protection-guide-remediate.md) (Updated) - Updated remediation guidance.

#### Policy and User Experience

Policy configuration has been streamlined to make it easier for administrators to deploy effective risk-based protection, while user experience improvements ensure legitimate users can remediate risks quickly without excessive friction.

- [**Identity Protection policies**](id-protection/concept-identity-protection-policies.md) (Updated) - Enhanced policy configuration and management.
- [**Identity Protection user experience**](id-protection/concept-identity-protection-user-experience.md) (Updated) - Improved user experience during risk remediation.
- [**Configure risk policies**](id-protection/howto-identity-protection-configure-risk-policies.md) (Updated) - Streamlined risk policy configuration.
- [**Remediate and unblock users**](id-protection/howto-identity-protection-remediate-unblock.md) (Updated) - Enhanced remediation workflows.

### Microsoft Entra External ID

Microsoft Entra External ID introduces new capabilities for customizing user experiences and managing external identities.

#### Branding and Customization

Branding themes transform how external users experience sign-in across different applications. Organizations can create distinct visual experiences for different apps or customer segments, with full control over backgrounds, logos, colors, layouts, and custom text. This enables white-label experiences for different products or customer tiers while maintaining centralized identity management.

- [**Customize sign-in experience with branding themes (Preview)**](external-id/customers/how-to-customize-branding-themes-apps.md) (New) - Create unique authentication experiences for different applications with customizable themes including background images, favicons, layouts, headers, and footers. Support for up to 5 branding themes per tenant.
- [**Sign-in with alias (Preview)**](external-id/customers/how-to-sign-in-alias.md) (New) - Enable users to sign in with custom usernames or aliases in addition to their email addresses for external tenants.
- [**Customize branding for customers**](external-id/customers/how-to-customize-branding-customers.md) (Updated) - Enhanced branding customization options.

#### Security and Fraud Protection

Enhanced fraud protection integration capabilities help organizations combat account takeover, fake accounts, and other identity-based fraud targeting external users.

- [**Integrate fraud protection**](external-id/customers/how-to-integrate-fraud-protection.md) (Updated) - Enhanced fraud protection integration capabilities.

#### Authentication Methods

Updated authentication method configurations provide more options for balancing security and user experience for external users, including support for passwordless authentication and modern authentication methods.

- [**Authentication methods for customers**](external-id/customers/concept-authentication-methods-customers.md) (Updated) - Updated authentication method options and configurations.

#### FAQs and Support

Expanded FAQs address common questions about new features like synced passkeys and help organizations successfully deploy External ID capabilities.

- [**External ID for customers FAQ**](external-id/customers/faq-customers.md) (Updated) - Updated frequently asked questions including synced passkeys information.

### Microsoft Entra Verified ID

Microsoft Entra Verified ID continues to expand with new identity verification partnerships and capabilities.

Expanded partnerships with identity verification providers give organizations more choices for implementing verified credentials, enabling diverse use cases from employee onboarding to customer age verification.

- [**Identity verification partners**](verified-id/idv-partners.md) (Updated) - Updated list of identity verification partners and integration capabilities.

### Microsoft Entra Workload ID

Enhancements to managed identities improve security and simplify authentication for applications and services running on Azure.

- [**Managed identities overview**](identity/managed-identities-azure-resources/overview.md) (Updated) - Enhanced managed identity capabilities and documentation.
- [**Managed identity libraries reference**](identity/managed-identities-azure-resources/reference-managed-identity-libraries.md) (Updated) - Updated library references and SDK information.

---

## Microsoft Entra ID

### Conditional Access

Microsoft Entra Conditional Access now supports AI agents as first-class identities and introduces enhanced policy capabilities.

#### Conditional Access for Agents

Conditional Access for Agent ID represents a major advancement in securing AI systems, bringing the same Zero Trust principles used for human users to autonomous agents. Organizations can create policies that evaluate agent risk levels, target specific agent blueprints or individual agents, and control access to sensitive resources. This enables scenarios like blocking all risky agents, restricting agent access to specific applications, or requiring additional controls based on the sensitivity of requested resources.

- [**Conditional Access and agent identities (Preview)**](identity/conditional-access/agent-id.md) (New) - Apply Zero Trust controls to AI agents with agent-specific Conditional Access policies, including support for agent risk conditions and resource targeting.
- [**Block all high-risk agent identities policy**](identity/conditional-access/policy-agent-block-high-risk.md) (New) - Template policy to block agent identities flagged as high risk.
- [**Block all agent identities policy**](identity/conditional-access/policy-agent-identities-block-all.md) (New) - Template policy to block all agent identity access.
- [**Block all agent users policy**](identity/conditional-access/policy-agent-users-block-all.md) (New) - Template policy to block all agent user access.

#### Policy Enhancements

Expanded policy capabilities provide administrators with more granular control over access decisions, with enhanced conditions for evaluating sign-in context and improved grant controls for enforcing compliance requirements.

- [**Conditional Access conditions**](identity/conditional-access/concept-conditional-access-conditions.md) (Updated) - Enhanced conditions including agent risk support.
- [**Conditional Access grant controls**](identity/conditional-access/concept-conditional-access-grant.md) (Updated) - Updated grant control options.
- [**Common Conditional Access policies**](identity/conditional-access/concept-conditional-access-policy-common.md) (Updated) - Updated common policy templates.
- [**Conditional Access users and groups**](identity/conditional-access/concept-conditional-access-users-groups.md) (Updated) - Enhanced user and group targeting capabilities.
- [**Risk-based user policy**](identity/conditional-access/policy-risk-based-user.md) (Updated) - Improved risk-based policy configurations.

### Authentication

Microsoft Entra authentication introduces significant updates to passwordless capabilities, self-service account recovery, and passkey management.

#### Self-Service Account Recovery (Preview)

Self-Service Account Recovery addresses a critical gap in identity recovery scenarios—what happens when users lose access to all their authentication methods. Unlike password reset which requires at least one working authentication method, account recovery enables complete identity re-establishment through verified identity proofing. Integration with Microsoft Entra Verified ID and certified identity verification partners ensures only legitimate account owners can recover access, eliminating the social engineering risks associated with traditional helpdesk recovery processes.

- [**Overview of Microsoft Entra ID Account Recovery**](identity/authentication/concept-self-service-account-recovery.md) (New) - Enable users to regain access when they've lost all authentication methods through comprehensive identity verification using Microsoft Entra Verified ID and third-party identity verification providers.
- [**Configure account recovery**](identity/authentication/how-to-account-recovery-configure.md) (New) - Step-by-step guide for configuring account recovery including provider selection, user targeting, and policy settings.
- [**User setup for account recovery**](identity/authentication/how-to-account-recovery-user-setup.md) (New) - End-user guidance for setting up and using account recovery.
- [**Account recovery FAQ**](identity/authentication/self-service-account-recovery.yml) (New) - Frequently asked questions about account recovery.

#### Passkey Management

Passkey profiles revolutionize how organizations deploy passkeys by enabling different security policies for different user populations. High-security users like administrators can be required to use only attested, device-bound passkeys from approved vendors, while regular users might be allowed synced passkeys for better convenience. Synced passkeys represent a major usability improvement, allowing users to share passkeys across their devices through secure cloud synchronization while maintaining strong phishing resistance.

- [**Passkey (FIDO2) profiles (Preview)**](identity/authentication/how-to-authentication-passkey-profiles.md) (New) - Enable granular group-based configurations for passkey FIDO2 authentication with separate profiles for different user groups. Support for attestation enforcement, passkey type targeting (device-bound or synced), and AAGUID restrictions.
- [**Synced passkeys (FIDO2) (Preview)**](identity/authentication/how-to-authentication-synced-passkeys.md) (New) - Enable synced passkeys that work across devices through cloud synchronization, enhancing user experience while maintaining security.
- [**Synced passkey FAQ**](identity/authentication/synced-passkey-faq.yml) (New) - Frequently asked questions about synced passkeys.

#### Authentication Methods and Concepts

Documentation restructuring provides clearer guidance on authentication methods, with dedicated articles for each major authentication type and improved navigation. New platform-specific documentation for Windows Hello and macOS Platform Credential helps organizations deploy passwordless authentication across diverse device ecosystems.

- [**Passkeys (FIDO2) concept**](identity/authentication/concept-authentication-passkeys-fido2.md) (New) - Comprehensive overview of passkey authentication including device-bound and synced passkeys.
- [**Windows Hello for Business concept**](identity/authentication/concept-authentication-windows-hello.md) (New) - Dedicated documentation for Windows Hello for Business authentication.
- [**Platform Credential for macOS**](identity/authentication/concept-authentication-platform-credential-for-macos.md) (New) - Documentation for macOS platform credential support.
- [**Authentication overview**](identity/authentication/overview-authentication.md) (Updated) - Major revision covering passkey adoption, account recovery, and modern authentication methods.
- [**Authentication methods**](identity/authentication/concept-authentication-methods.md) (Updated) - Restructured documentation with improved organization of authentication methods.
- [**Manage authentication methods**](identity/authentication/concept-authentication-methods-manage.md) (Updated) - Enhanced authentication method management guidance.
- [**Authenticator app**](identity/authentication/concept-authentication-authenticator-app.md) (Updated) - Updated Microsoft Authenticator documentation.
- [**Phone authentication options**](identity/authentication/concept-authentication-phone-options.md) (Updated) - Clarified phone authentication capabilities including voice call focus.

#### Passwordless Authentication

Streamlined deployment guidance and updated registration processes make it easier for organizations to roll out passwordless authentication at scale, with improved user experiences that reduce friction during registration and sign-in.

- [**Enable passkey (FIDO2)**](identity/authentication/how-to-enable-passkey-fido2.md) (Updated) - Updated passkey enablement guidance with profile support.
- [**Register passkey with security key**](identity/authentication/how-to-register-passkey-with-security-key.md) (Updated) - Updated registration process.
- [**Register passkey**](identity/authentication/how-to-register-passkey.md) (Updated) - General passkey registration updates.
- [**Sign in with passkey**](identity/authentication/how-to-sign-in-passkey.md) (Updated) - Updated sign-in experience documentation.
- [**Deploy phishing-resistant passwordless authentication**](identity/authentication/how-to-deploy-phishing-resistant-passwordless-authentication.md) (Updated) - Enhanced deployment guidance.
- [**Plan password scramble for phishing-resistant passwordless authentication**](identity/authentication/how-to-plan-password-scramble-phishing-resistant-passwordless-authentication.md) (Updated) - Updated password scrambling guidance.
- [**Plan persona for phishing-resistant passwordless authentication**](identity/authentication/how-to-plan-persona-phishing-resistant-passwordless-authentication.md) (Updated) - Revised persona guidance for passwordless authentication adoption.
- [**FIDO2 hardware vendor attestation**](identity/authentication/concept-fido2-hardware-vendor.md) (Updated) - Updated vendor attestation requirements.

#### External Authentication Methods

Expanded FAQ coverage addresses common deployment questions, including support for external authentication methods on Windows 10 devices.

- [**Manage external authentication methods**](identity/authentication/how-to-authentication-external-method-manage.md) (Updated) - Added FAQ on External Authentication Methods for Windows 10.

#### Multifactor Authentication

Updated MFA documentation provides clearer deployment guidance and improved app password management for legacy applications that don't support modern authentication.

- [**Get started with MFA**](identity/authentication/howto-mfa-getstarted.md) (Updated) - Updated MFA deployment guidance.
- [**MFA app passwords**](identity/authentication/howto-mfa-app-passwords.md) (Updated) - Updated app password documentation.

#### Certificate-Based Authentication

Revised technical documentation clarifies certificate revocation checking processes and provides more detailed guidance on certificate authority requirements.

- [**Certificate-based authentication technical deep dive**](identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md) (Updated) - Revised certificate revocation section and technical details.

#### Additional Authentication Updates

- [**Feature availability**](identity/authentication/feature-availability.md) (Updated) - Updated feature availability matrix.
- [**Troubleshoot authentication strengths**](identity/authentication/troubleshoot-authentication-strengths.md) (Updated) - Enhanced troubleshooting guidance.
- [**Kerberos authentication**](identity/authentication/kerberos.md) (Updated) - Updated Kerberos documentation.

### Hybrid Identity

Updated hybrid identity documentation provides clearer guidance on source of authority concepts and configuration, helping organizations manage the boundary between cloud and on-premises identity sources.

- [**User source of authority overview**](identity/hybrid/user-source-of-authority-overview.md) (Updated) - Enhanced source of authority concepts.
- [**Configure user source of authority**](identity/hybrid/how-to-user-source-of-authority-configure.md) (Updated) - Updated configuration guidance.
- [**Connect Health agent install**](identity/hybrid/connect/how-to-connect-health-agent-install.md) (Updated) - Updated agent installation instructions.
- [**Connect install prerequisites**](identity/hybrid/connect/how-to-connect-install-prerequisites.md) (Updated) - Updated prerequisite requirements.

### Device Identity

New guidance for third-party devices ensures organizations can manage browser access security across diverse device ecosystems, while updated documentation for device join and macOS SSO improves deployment success rates.

- [**Browser access guidance for third-party devices**](identity/devices/browser-access-guidance-third-party-devices.md) (New) - Guidance for managing browser access from third-party (non-Windows) devices.
- [**Device join with Microsoft Entra Company Portal**](identity/devices/device-join-microsoft-entra-company-portal.md) (Updated) - Updated device join process documentation.
- [**macOS Platform SSO deployment for external customers**](identity/devices/macos-psso-deployment-eocustomers.md) (Updated) - Enhanced macOS SSO deployment guidance.

### Provisioning

Clarified documentation helps organizations understand that identity verification steps may vary across different provisioning partners, setting appropriate expectations during deployment.

- [**Configure Workday termination lookahead**](identity/app-provisioning/configure-workday-termination-lookahead.md) (Updated) - Added note about verification steps varying by partner.

### Enterprise Applications

Updated application management documentation provides clearer guidance on controlling user sign-in and managing consent policies to balance security with application access needs.

- [**Disable user sign-in**](identity/enterprise-apps/disable-user-sign-in-portal.md) (Updated) - Updated sign-in management documentation.
- [**Manage app consent policies**](identity/enterprise-apps/manage-app-consent-policies.md) (Updated) - Enhanced consent policy management guidance.

### User Management

Improved documentation clarifies the process for converting external users to internal users, including important considerations for synced users, while removing outdated references to ensure accuracy.

- [**Convert external users to internal**](identity/users/convert-external-users-internal.md) (Updated) - Clarified synced user conversion process and removed dead links.
- [**Licensing service plan reference**](identity/users/licensing-service-plan-reference.md) (Updated) - Updated licensing information.

### Domain Services

Updated TLS enforcement timeline ensures organizations have accurate information for planning their Domain Services security compliance.

- [**Domain Services TLS enforcement reference**](identity/domain-services/reference-domain-services-tls-enforcement.md) (Updated) - Updated TLS enforcement deadline to November 30, 2025.

---

## Security Copilot + Microsoft Entra

Security Copilot integration with Microsoft Entra continues to enhance AI-powered security operations.

Security Copilot's deep integration with Microsoft Entra brings generative AI capabilities to identity and access management, enabling security teams to work more efficiently through natural language interactions. The Conditional Access optimization agent uses AI to analyze policies, detect configuration issues, and suggest improvements based on best practices and organizational patterns. Enhanced monitoring and investigation capabilities help security analysts quickly understand complex identity threats and take appropriate action.

- [**Conditional Access agent optimization**](security-copilot/conditional-access-agent-optimization.md) (Updated) - Enhanced AI-powered Conditional Access optimization.
- [**Conditional Access agent optimization chat**](security-copilot/conditional-access-agent-optimization-chat.md) (Updated) - Improved chat interface for policy optimization.
- [**Review Conditional Access suggestions**](security-copilot/conditional-access-agent-optimization-review-suggestions.md) (Updated) - Enhanced suggestion review workflow with updated policy details interface.
- [**Entra agents in Security Copilot**](security-copilot/entra-agents.md) (Updated) - Updated agent capabilities in Security Copilot.
- [**Entra ID scenarios**](security-copilot/entra-id-scenarios.md) (Updated) - Enhanced scenario coverage.
- [**Entra monitoring and operations**](security-copilot/entra-monitoring-operations.md) (Updated) - Improved monitoring capabilities.
- [**Entra security scenarios**](security-copilot/entra-security-scenarios.md) (Updated) - Updated security scenario guidance.

---

## Microsoft Identity Platform

The Microsoft Identity Platform provides updated guidance for developers building applications that integrate with Microsoft Entra ID.

Updated token lifetime configuration documentation helps developers understand best practices for balancing security and user experience when configuring token expiration policies.

- [**Configurable token lifetimes**](identity-platform/configurable-token-lifetimes.md) (Updated) - Updated token lifetime configuration guidance.

---

## Microsoft Entra Fundamentals

### What's New and Documentation

The What's New documentation tracks all the latest features and capabilities added to Microsoft Entra, providing monthly updates that help administrators stay current with platform evolution.

- [**What's new in Microsoft Entra**](fundamentals/whats-new.md) (Updated) - October 2025 updates including Account Recovery, Passkey Profiles, Synced Passkeys, and Agent ID capabilities.
- [**What's new archive**](fundamentals/whats-new-archive.md) (Updated) - April 2025 and earlier months added to archive.

### Security and Zero Trust

Enhanced security guidance helps organizations implement Zero Trust principles across their identity infrastructure, with updated recommendations for monitoring, detecting threats, and protecting both identities and tenant configurations.

- [**Configure security recommendations**](fundamentals/configure-security.md) (Updated) - Updated security recommendation configurations.
- [**Zero Trust: Monitor and detect**](fundamentals/zero-trust-monitor-detect.md) (Updated) - Enhanced monitoring guidance.
- [**Zero Trust: Protect identities**](fundamentals/zero-trust-protect-identities.md) (Updated) - Updated identity protection strategies.
- [**Zero Trust: Protect tenants**](fundamentals/zero-trust-protect-tenants.md) (Updated) - Enhanced tenant protection guidance.

### Backup and Resilience

Updated backup authentication guidance ensures organizations have resilient authentication systems that can withstand outages and maintain user access during disruptions.

- [**Backup authentication system**](architecture/backup-authentication-system.md) (Updated) - Enhanced backup authentication guidance.

---

## Architecture and Guidance

### Security Recommendations

Microsoft Entra now includes numerous updated and new security recommendations to help organizations strengthen their security posture. These recommendations provide actionable guidance based on Microsoft's security research and real-world threat intelligence, helping organizations identify and remediate configuration issues before they can be exploited.

**New Recommendations:**
- [**Recommendation 21780**](includes/secure-recommendations/21780.md) (New)
- [**Recommendation 21813**](includes/secure-recommendations/21813.md) (New)
- [**Recommendation 21840**](includes/secure-recommendations/21840.md) (New)
- [**Recommendation 21842**](includes/secure-recommendations/21842.md) (New)
- [**Recommendation 21844**](includes/secure-recommendations/21844.md) (New)
- [**Recommendation 21846**](includes/secure-recommendations/21846.md) (New)
- [**Recommendation 21849**](includes/secure-recommendations/21849.md) (New)
- [**Recommendation 21862**](includes/secure-recommendations/21862.md) (New)
- [**Recommendation 21875**](includes/secure-recommendations/21875.md) (New)
- [**Recommendation 21878**](includes/secure-recommendations/21878.md) (New)
- [**Recommendation 21896**](includes/secure-recommendations/21896.md) (New)
- [**Recommendation 21929**](includes/secure-recommendations/21929.md) (New)
- [**Recommendation 21955**](includes/secure-recommendations/21955.md) (New)
- [**Recommendation 24570**](includes/secure-recommendations/24570.md) (New)

**Updated Recommendations:** Over 50 existing security recommendations have been updated with enhanced guidance, improved detection capabilities, and refined remediation steps to help organizations maintain strong security postures.

---

## Summary

Microsoft Ignite 2025 represents a significant milestone in Microsoft Entra's evolution, with groundbreaking capabilities for securing AI agents, enhanced identity governance, advanced authentication methods, and comprehensive threat protection. These updates enable organizations to:

- **Secure AI at scale** with purpose-built identity constructs for AI agents
- **Enhance user experience** with self-service account recovery and synced passkeys
- **Strengthen governance** with delegated workflow management and custom triggers
- **Improve threat detection** with AI-powered risk analysis and agent-specific protections
- **Simplify customization** with branding themes and flexible authentication options
- **Extend Zero Trust** to AI agents through Conditional Access

For the latest updates and announcements, visit the [Microsoft Entra What's New](fundamentals/whats-new.md) page.

---

## Related Content

- [Microsoft Entra documentation](index.yml)
- [Microsoft Entra ID Governance documentation](id-governance/index.yml)
- [Microsoft Entra External ID documentation](external-id/index.yml)
- [Microsoft Identity Platform documentation](identity-platform/index.yml)
- [Microsoft Entra ID Protection documentation](id-protection/index.yml)
- [Global Secure Access documentation](global-secure-access/index.yml)
