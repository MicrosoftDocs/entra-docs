param ([System.Collections.IDictionary] $settings, [string] $termFilePath)

$d = [ordered] @{}

$d.Add('invalid-rbac-entra-custom', @(
    '(?<=\()RBAC\) *\((?:Azure|Entra|Microsoft Entra) RBAC(?=\))!!RBAC'
) )

$d.Add('ignored-permissions-entra-custom', @(
    '(?-i)(?<!\.)\bmicrosoft\.(?!(?:com|de|us)/)\w+/'
) )

$d.Add('ignored-roles-entra-custom', @(
    'Guest User'
) )

return $d
