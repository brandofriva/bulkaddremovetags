# BULK REMOVE TAGS
# Method to updates tags - see bottom to change parameters
function Remove-TagsFunction ($tagname, $tagvalue, $resourcegroup) {
	$param = "Get-AzResource -TagName ""$tagname"" "
	if ($tagvalue -ne $null -and $tagvalue -ne '') {$param = "$param -TagValue ""$tagvalue"""}
	if ($resourcegroup -ne $null -and $resourcegroup -ne '') {$param = "$param -ResourceGroupName ""$resourcegroup"""}
    $resources = iex $param

    foreach ($resource in $resources) {
        Write-Host "Removing tag from " $resource.Name
		if ($tagvalue -ne $null -and $tagvalue -ne '') { $deletedtag = @{"$tagname" = "$tagvalue" }} else { $deletedtag = @{"$tagname" = "" }}
		#Write-Host "Update-AzTag -ResourceId " $resource.ResourceId " -Tag " $deletedtag " -Operation Delete"
        Update-AzTag -ResourceId $resource.ResourceId -Tag $deletedtag -Operation Delete
        Write-Host "Tag removed from " $resource.Name -ForegroundColor Green
    }
}

# CHANGE PARAMETERS HERE
# If tags are blank they are ignored
Remove-TagsFunction -tagName "DeleteThisTag" -tagvalue "DeleteThisTag" -resourcegroup "RG1"