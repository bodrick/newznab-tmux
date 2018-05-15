<div class="header" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
	 xmlns="http://www.w3.org/1999/html">
	<div class="breadcrumb-wrapper">
		<ol class="breadcrumb">
			<li><a href="{$smarty.const.WWW_TOP}{$site->home_link}">Home</a></li>
			/  {if !empty({$catname->parent->title})}<a href="{$smarty.const.WWW_TOP}/browse/{$catname->parent->title}">{$catname->parent->title}</a>{else}<a href="{$smarty.const.WWW_TOP}/browse/{$catname->title}">{$catname->title}</a>{/if}
			/ {if !empty({$catname->parent->title})}<a href="{$smarty.const.WWW_TOP}/browse/{$catname->title}">{$catname->title}</a>{else}All{/if}
		</ol>
	</div>
</div>
<div class="well well-sm">
	{include file='search-filter.tpl'}
</div>
<form id="nzb_multi_operations_form" action="get">
	<div class="box-body"
	<div class="row">
		<div class="col-lg-12 col-sm-12 col-xs-12">
			<div class="panel panel-default">
				<div class="panel-body pagination2">
					<div class="row">
						<div class="col-md-8">
							<div class="nzb_multi_operations">
								View: <strong>Covers</strong> | <a
										href="{$smarty.const.WWW_TOP}/browse/movies/{$categorytitle}">List</a><br/>
								With Selected:
								<div class="btn-group">
									<button type="button"
											class="nzb_multi_operations_download btn btn-sm btn-success"
											data-toggle="tooltip" data-placement="top" title
											data-original-title="Download NZBs">
										<i class="fa fa-cloud-download"></i></button>
									<button type="button"
											class="nzb_multi_operations_cart btn btn-sm btn-info"
											data-toggle="tooltip" data-placement="top" title
											data-original-title="Send to my Download Basket">
										<i class="fa fa-shopping-basket"></i></button>

									{if isset($sabintegrated) && $sabintegrated !=""}
										<button type="button"
												class="nzb_multi_operations_sab btn btn-sm btn-primary"
												data-toggle="tooltip" data-placement="top" title
												data-original-title="Send to Queue">
											<i class="fa fa-share"></i></button>
									{/if}
									{if isset($isadmin)}
										<input type="button"
											   class="nzb_multi_operations_edit btn btn-sm btn-warning"
											   value="Edit"/>
										<input type="button"
											   class="nzb_multi_operations_delete btn btn-sm btn-danger"
											   value="Delete"/>
									{/if}
								</div>
							</div>
						</div>
						<div class="col-md-4">
							{$results->links()}
						</div>
					</div>
					<hr>
					{foreach $resultsadd as $result}
						<!-- Iteratie: {counter} -->
						{if isset($result->category_name)}
							{assign var="catnamesplit" value=">"|explode:$result->category_name}
						{/if}
						{if $result@iteration is odd by 1}
							<!-- Begin Row -->
							<div class="row">
								<!-- Left -->
								<div class="col-md-6 small-gutter-right movie-height">
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row small-gutter-left">
												<div class="col-md-3 small-gutter-left">
													{foreach $result->languages as $movielanguage}
														{release_flag($movielanguage, browse)}
													{/foreach}
													<a href="{$smarty.const.WWW_TOP}/movies/?imdb={$result->imdbid}"><img
																class="cover img-responsive img-rounded"
																src="{if isset($result->cover) && $result->cover == 1}{$smarty.const.WWW_TOP}/covers/movies/{$result->imdbid}-cover.jpg{else}{$smarty.const.WWW_ASSETS}/images/no-cover.png{/if}"
																width="140" border="0"
																alt="{$result->title|escape:"htmlall"}"/> {if !empty($result->failed)}
															<i class="fa fa-exclamation-circle" style="color: red"
															   title="This release has failed for some users"></i>
														{/if}</a>
													<a target="_blank"
													   href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result->imdbid}/"
													   name="imdb{$result->imdbid}" title="View IMDB page"
													   class="label label-primary" rel="imdb">IMDB</a>
													<a target="_blank"
													   href="{$site->dereferrer_link}http://trakt.tv/search/imdb/tt{$result->imdbid}/"
													   name="trakt{$result->imdbid}" title="View Trakt page"
													   class="label label-primary" rel="trakt">TRAKT</a>
													{if $result->nfoid > 0}<a
														href="{$smarty.const.WWW_TOP}/nfo/{$result->guid}"
														title="View NFO" class="modal_nfo label label-primary"
														rel="nfo">NFO</a>{/if}
													<a class="label label-primary"
													   href="{$smarty.const.WWW_TOP}/browse/group?g={$result->group_name}"
													   title="Browse releases in {$result->group_name|replace:"alt.binaries":"a.b"}">Group</a>
													<a class="label label-primary"
													   href="{$smarty.const.WWW_TOP}/mymovies/add/{$result->imdbid}?from={$smarty.server.REQUEST_URI|escape:"url"}"
													   rel="add" name="movies{$result->imdbid}" title="Add to My Movies">Add</a>
												</div>
												<div class="col-md-9 small-gutter-left table-responsive">
																<span class="release-title"><a class="text-muted"
																							   href="{$smarty.const.WWW_TOP}/movies/?imdb={$result->imdbid}">{$result->title|escape:"htmlall"}</a></span>
													<div class="release-subtitle">{if $result->genre != ''}
															<b>Genre: </b>
															{$result->genre}, {/if}</div>
													<div class="release-subtitle">{if $result->plot != ''}{$result->plot} {/if}</div>
													<div class="release-subtitle">{if $result->director != ''}<b>Director: </b>{$result->director} {/if}
													</div>
													<div class="release-subtitle">{if $result->actors != ''}
															<b>Starring: </b>
															{$result->actors} {/if}</div>
													<table class="data table table-striped responsive-utilities jambo-table">
														<tr>
															<td id="guid{$result->guid}">
																<label>
																	<input type="checkbox"
																		   class="flat"
																		   value="{$result->guid}"
																		   id="chksingle"/>
																</label>
																<span class="label label-primary">{if isset($catsplit[0])} {$catsplit[0]}{/if}</span>
																<span class="label label-danger">{if isset($catsplit[1])} {$catsplit[1]}{/if}</span>
																<span class="label label-primary">{$result->year}</span>
																<span class="label label-primary">{if $result->rating != ''}{$result->rating}/10{/if}</span>
																<span class="label label-primary">{if $result->rtrating != ''}RottenTomatoes Score {$result->rtrating}{/if}</span>
																<span class="label label-primary">{$result->size|fsize_format:"MB"}</span>
																<span class="label label-primary">Posted {$result->postdate|timeago}
																	ago</span>
																<br/><br/><br/>
																<div class="release-name text-muted"><a
																			href="{$smarty.const.WWW_TOP}/details/{$result->guid}">{$result->searchname|escape:"htmlall"}</a>
																</div>
																<div>
																	<a role="button" class="btn btn-default btn-xs"
																	   data-toggle="tooltip" data-placement="top" title
																	   data-original-title="Download NZB"
																	   href="{$smarty.const.WWW_TOP}/getnzb?id={$result->guid}"><i
																				class="fa fa-cloud-download"></i><span
																				class="badge"> {$result->grabs}
																			Grab{if $result->grabs != 1}s{/if}</span></a>
																	<a role="button" class="btn btn-default btn-xs"
																	   href="{$smarty.const.WWW_TOP}/details/{$result->guid}/#comments"><i
																				class="fa fa-comment-o"></i><span
																				class="badge"> {$result->comments}
																			Comment{if $result->comments != 1}s{/if}</span></a>
																	<span class="btn btn-hover btn-default btn-xs icon_cart text-muted"
																		  id="guid{$result->guid}"
																		  data-toggle="tooltip" data-placement="top"
																		  title
																		  data-original-title="Send to my download basket"><i
																				class="fa fa-shopping-basket"></i></span>
																	{if isset($sabintegrated) && $sabintegrated !=""}
																		<span class="btn btn-hover btn-default btn-xs icon_sab text-muted"
																			  id="guid{$result->guid}"
																			  data-toggle="tooltip" data-placement="top"
																			  title
																			  data-original-title="Send to my Queue"><i
																					class="fa fa-share"></i></span>
																	{/if}
																	{if !empty($cpurl) && !empty($cpapi)}
																		<span
																				id="imdb{$result->imdbid}"
																				href="javascript:;"
																				class="btn btn-hover btn-default btn-xs sendtocouch text-muted"
																				data-toggle="tooltip"
																				data-placement="top"
																				title
																				data-original-title="Send to CouchPotato">
																			<i class="fa fa-bed"></i>
																		</span>
																	{/if}
																	{if !empty($result->failed)}
																		<span class="btn btn-default btn-xs"
																			  title="This release has failed to download for some users">
																	<i class="fa fa-thumbs-o-up"></i> {$result->grabs}
																			Grab{if {$result->grabs} != 1}s{/if}
																			/ <i
																					class="fa fa-thumbs-o-down"></i> {$result->failed}
																			Failed Download{if {$result->failed} > 1}s{/if}</span>
																	{/if}
																</div>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- /Left -->
								{else}
								<!-- Right -->
								<div class="col-md-6 small-gutter-left movie-height">
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row small-gutter-left">
												<div class="col-md-3 small-gutter-left">
													{foreach $result->languages as $movielanguage}
														{release_flag($movielanguage, browse)}
													{/foreach}
													<a href="{$smarty.const.WWW_TOP}/movies/?imdb={$result->imdbid}"><img
																class="cover img-responsive img-rounded"
																src="{if isset($result->cover) && $result->cover == 1}{$smarty.const.WWW_TOP}/covers/movies/{$result->imdbid}-cover.jpg{else}{$smarty.const.WWW_ASSETS}/images/no-cover.png{/if}"
																width="140" border="0"
																alt="{$result->title|escape:"htmlall"}"/> {if !empty($result->failed)}
															<i class="fa fa-exclamation-circle" style="color: red"
															   title="This release has failed to download for some users"></i>
														{/if}</a>
													<a target="_blank"
													   href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result->imdbid}/"
													   name="imdb{$result->imdbid}" title="View IMDB page"
													   class="label label-primary" rel="imdb">IMDB</a>
													<a target="_blank"
													   href="{$site->dereferrer_link}http://trakt.tv/search/imdb/tt{$result->imdbid}/"
													   name="trakt{$result->imdbid}" title="View Trakt page"
													   class="label label-primary" rel="trakt">TRAKT</a>
													{if $result->nfoid > 0}<span><a
																href="{$smarty.const.WWW_TOP}/nfo/{$result->guid}"
																title="View NFO" class="modal_nfo label label-primary">NFO</a>
														</span>{/if}
													<a class="label label-primary"
													   href="{$smarty.const.WWW_TOP}/browse/group?g={$result->group_name}"
													   title="Browse releases in {$result->group_name|replace:"alt.binaries":"a.b"}">Group</a>
													<a class="label label-primary"
													   href="{$smarty.const.WWW_TOP}/mymovies/add/{$result->imdbid}?from={$smarty.server.REQUEST_URI|escape:"url"}"
													   rel="add" name="movies{$result->imdbid}" title="Add to My Movies">Add</a>
												</div>
												<div class="col-md-9 small-gutter-left table-responsive">
																<span class="release-title"><a class="text-muted"
																							   href="{$smarty.const.WWW_TOP}/movies/?imdb={$result->imdbid}">{$result->title|escape:"htmlall"}</a></span>
													<div class="release-subtitle">{if $result->genre != ''}
															<b>Genre: </b>
															{$result->genre}, {/if}</div>
													<div class="release-subtitle">{if $result->plot != ''}{$result->plot} {/if}</div>
													<div class="release-subtitle">{if $result->director != ''}<b>Director: </b>{$result->director} {/if}
													</div>
													<div class="release-subtitle">{if $result->actors != ''}
															<b>Starring: </b>
															{$result->actors} {/if}</div>
													<table class="data table table-striped responsive-utilities jambo-table">
														<tr>
															<td id="guid{$result->guid}">
																<label>
																	<input type="checkbox"
																		   class="flat"
																		   value="{$result->guid}"
																		   id="chksingle"/>
																</label>
																<span class="label label-primary">{if isset($catsplit[0])} {$catsplit[0]}{/if}</span>
																<span class="label label-danger">{if isset($catsplit[1])} {$catsplit[1]}{/if}</span>
																<span class="label label-primary">{$result->year}</span>
																<span class="label label-primary">{if $result->rating != ''}{$result->rating}/10{/if}</span>
																<span class="label label-primary">{if $result->rtrating != ''}RottenTomatoes Score {$result->rtrating}{/if}</span>
																<span class="label label-primary">{$result->size|fsize_format:"MB"}</span>
																<span class="label label-primary">Posted {$result->postdate|timeago}
																	ago</span>
																<br/><br/><br/>
																<div class="release-name text-muted"><a
																			href="{$smarty.const.WWW_TOP}/details/{$result->guid}">{$result->searchname|escape:"htmlall"}</a>
																</div>
																<div>
																	<a role="button" class="btn btn-default btn-xs"
																	   data-toggle="tooltip" data-placement="top" title
																	   data-original-title="Download NZB"
																	   href="{$smarty.const.WWW_TOP}/getnzb?id={$result->guid}"><i
																				class="fa fa-cloud-download"></i><span
																				class="badge"> {$result->grabs}
																			Grab{if $result->grabs != 1}s{/if}</span></a>
																	<a role="button" class="btn btn-default btn-xs"
																	   href="{$smarty.const.WWW_TOP}/details/{$result->guid}/#comments"><i
																				class="fa fa-comment-o"></i><span
																				class="badge"> {$result->comments}
																			Comment{if $result->comments != 1}s{/if}</span></a>
																	<span class="btn btn-hover btn-default btn-xs icon_cart text-muted"
																		  id="guid{$result->guid}"
																		  data-toggle="tooltip" data-placement="top"
																		  title
																		  data-original-title="Send to my download basket"><i
																				class="fa fa-shopping-basket"></i></span>
																	{if isset($sabintegrated) && $sabintegrated !=""}
																		<span class="btn btn-hover btn-default btn-xs icon_sab text-muted"
																			  id="guid{$result->guid}"
																			  data-toggle="tooltip" data-placement="top"
																			  title
																			  data-original-title="Send to my Queue"><i
																					class="fa fa-share"></i></span>
																	{/if}
																	{if !empty($cpurl) && !empty($cpapi)}
																		<span
																				id="imdb{$result->imdbid}"
																				href="javascript:;"
																				class="btn btn-hover btn-default btn-xs sendtocouch text-muted"
																				data-toggle="tooltip"
																				data-placement="top"
																				title
																				data-original-title="Send to CouchPotato">
																			<i class="fa fa-bed"></i>
																		</span>
																	{/if}
																	{if !empty($result->failed)}
																		<span class="btn btn-default btn-xs"
																			  title="This release has failed to download for some users">
																	<i class="fa fa-thumbs-o-up"></i> {$result->grabs}
																			Grab{if {$result->grabs} != 1}s{/if}
																			/ <i
																					class="fa fa-thumbs-o-down"></i> {$result->failed}
																			Failed Download{if {$result->failed} > 1}s{/if}</span>
																	{/if}
																</div>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- /Right -->
							</div>
							<hr>
							<!-- End Row -->
						{/if}
					{/foreach}
					<div class="row">
						<div class="col-md-8">
							<div class="nzb_multi_operations">
								View: <strong>Covers</strong> | <a
										href="{$smarty.const.WWW_TOP}/browse/movies/{$category->title}">List</a>
								<br/>
								With Selected:
								<div class="btn-group">
									<button type="button"
											class="nzb_multi_operations_download btn btn-sm btn-success"
											data-toggle="tooltip" data-placement="top" title
											data-original-title="Download NZBs">
										<i class="fa fa-cloud-download"></i></button>
									<button type="button"
											class="nzb_multi_operations_cart btn btn-sm btn-info"
											data-toggle="tooltip" data-placement="top" title
											data-original-title="Send to my Download Basket">
										<i class="fa fa-shopping-basket"></i></button>

									{if isset($sabintegrated) && $sabintegrated !=""}
										<button type="button"
												class="nzb_multi_operations_sab btn btn-sm btn-primary"
												data-toggle="tooltip" data-placement="top" title
												data-original-title="Send to Queue">
											<i class="fa fa-share"></i></button>
									{/if}
									{if isset($isadmin)}
										<input type="button"
											   class="nzb_multi_operations_edit btn btn-sm btn-warning"
											   value="Edit"/>
										<input type="button"
											   class="nzb_multi_operations_delete btn btn-sm btn-danger"
											   value="Delete"/>
									{/if}
								</div>
							</div>
						</div>
						<div class="col-md-4">
							{$results->links()}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
