function GetWebsiteText ($url) {
    $Response = wget -Uri $url
    $Text = $Response.ParsedHtml.body.innerText

    Write-Output $Text
}
