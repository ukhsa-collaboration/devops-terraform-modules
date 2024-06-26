
# Azure B2C Deployment and Configuration
This document describes how to deploy and configure Azure B2C.

## Prerequisite

### Note :
When creating an Azure B2C directory, the user who creates it becomes the owner of the new directory by default. This is achieved by the user account being added to the B2C directory as an External Member from the parent directory. Service Principals cannot be added as external members of other directories, therefore it's NOT POSSIBLE for a Service Principal to create a B2C directory. See the open case. https://github.com/hashicorp/terraform-provider-azurerm/issues/14941
Thus, the account that can be used to run this module will need to be a user acccount with the permissions listed below.

1. Tenant admin or tenant creator role is required to run this module. Ensure that the user account running this module have the Tenant admin or tenant creator role. If not, please reach out to the ADAM team.

2. Ensure that the user account running this module have the Contributor role within the subscription or a resource group within the subscription is required.


## Additional Configuration
1. Register web application and create a client secret in the B2C tenant - reach out to the ADAM team to create an application registration and client secret in the B2C Tenant you created for the app you are creating. Ensure to provide the Tenant ID  and the redirect URL (obtain from developers) to the ADAM team. https://learn.microsoft.com/en-us/azure/active-directory-b2c/register-apps
2. Deploy custom policies with GitHub Actions - https://learn.microsoft.com/en-us/azure/active-directory-b2c/deploy-custom-policies-github-action
3. Add Azure Active Directory B2C (Azure AD B2C) authentication to your web applications. The application developers can use the guide below to add Azure B2C authetication to the app. - https://learn.microsoft.com/en-us/azure/active-directory-b2c/index-web-app
4. Customise Sign Up and Sign In UI/UX - https://learn.microsoft.com/en-us/azure/active-directory-b2c/customize-ui-with-html?pivots=b2c-custom-policy
