<div class="well well-sm">
	<h1>{$title}</h1>

	{if $releaselist}
		{$pager}
		<table style="margin-top:10px;" class="data table table-striped responsive-utilities jambo-table Sortable">

			<tr>
				<th>name</th>
				<th>category</th>
				<th>size</th>
				<th>files</th>
				<th>postdate</th>
				<th>adddate</th>
				<th>grabs</th>
				<th>options</th>
			</tr>

			{foreach from=$releaselist item=release}
				<tr class="{cycle values=",alt"}">
					<td title="{$release.name}"><a
								href="{$smarty.const.WWW_TOP}/release-edit.php?id={$release.guid}">{$release.searchname|escape:"htmlall"|wordwrap:75:"\n":true}</a>
					</td>
					<td class="less">{$release.category_name}</td>
					<td class="less right">{$release.size|fsize_format:"MB"}</td>
					<td class="less mid"><a href="release-files.php?id={$release.guid}">{$release.totalpart}</a></td>
					<td class="less">{$release.postdate|date_format}</td>
					<td class="less">{$release.adddate|date_format}</td>
					<td class="less mid">{$release.grabs}</td>
					<td><a href="{$smarty.const.WWW_TOP}/release-delete.php?id={$release.guid}">delete</a></td>
				</tr>
			{/foreach}

		</table>
		<br/>
		{$pager}
	{else}
		<p>No releases available.</p>
	{/if}
</div>
