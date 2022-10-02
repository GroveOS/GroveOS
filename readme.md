# Prerequisites
Familiarity with:
- [CouchCMS](https://www.couchcms.com)
- [Template inheritance](https://www.couchcms.com/forum/viewtopic.php?f=5&t=10984)
- [Smart embed](https://docs.couchcms.com/miscellaneous/smart_embed.html)

- - -

# Install
```bash
cd my-project
curl -S https://install.groveos.net | bash
```

## Installation notes
You may have noticed, the installation declares *embed* as the Couch snippets directory in the supplied *couch/config.php* file. We prefer to keep it that way. You may also notice a blank index.php template. This was created during the installation process using the `bash ./grove.sh create index` command, which we'll get to in a bit.

- - -

# Creating / removing templates
We use the included `./grove.sh` bash script to create and remove templates and their associated template files.

**Create a template**
```bash
bash ./grove.sh create posts
```

**Remove a template**
```bash
bash ./grove.sh remove posts
```

- - -

# Development
Instead of writing all your CouchCMS code within the root template file, GroveOS follows a convention of separating out the following areas:
- **Template definition** (in the root template file)
- **Editables** (in the `embed/template` folder)
- **Admin panel config form view** (in the `embed/template` folder)
- **Admin panel config list view** (in the `embed/template` folder)
- **Global variables** (in the `embed/template` folder)
- **Smart views** (in the `embed` folder)

## Template definition
We can define the template's attributes (such as `title`, `clonable`, `icon`, etc) by editing the `<template>` tag in the template file itself. This should feel pretty natural to native CouchCMS speakers.

For instance:
```html
[...]
<cms:template title='Posts' clonable='1' icon='pencil'>
	[...]
</cms:template>
[...]
```

## Editables
We can define the template's editable fields in the `embed/template/editables` folder, where we have a file for each template (assuming it was created using the `./grove.sh create` command).

For instance:
```html
<!-- embed/template/editables/posts.html -->
<cms:editable
	name='author'
	label='Author'
	type='relation'
	has='one'
	masterpage='authors.php'
	advanced_gui='1'
	order='1'
/>

<cms:editable
	name='image'
	label='Image'
	type='image'
	show_preview='1'
	preview_height='180'
	order='2'
/>
```

## Admin panel config form view
To configure the admin panel form view, editing the template's associated file in `embed/template/config-form`.

```html
<!-- embed/template/config-form/posts.html -->
<cms:config_form_view>
	<cms:field 'k_page_name' label='Slug' group='_advanced_settings_' order='99' />
</cms:config_form_view>
```

## Admin panel config list view
Configure the admin panel list view by editing the template's associated file in `embed/template/config-form`.

```html
<!-- embed/template/config-list/posts.html -->
<cms:config_list_view searchable='1' limit='10' />
```

## Global variables
We like to include global project variables in a single file, which is included in the `embed/forms/page.html` *extends* file, within the `global-vars` block. This means it's included by default, but you can omit it like so:

```html
<!-- embed/posts-default.html -->
<cms:extends 'forms/page.html' />

<cms:block 'global-vars'><!-- nothing here now --></cms:block>

<cms:block 'content'>
	[...]
</cms:block>
```

## Smart views
If you were paying close attention, you may have noticed the `embed/posts-default.html` file in the previous section. That's because we use Couch's **smart_embed** by default. If you're not familiar with the **smart_embed** tag, [go read up on it](https://docs.couchcms.com/miscellaneous/smart_embed.html).

Each time you create a new template, the `./grove.sh` script will create the default view file. You'll need to create any additional views manually.

For instance:

```bash
bash ./grove.sh create authors  # Create a new authors template (and an authors-default.html view)
vim embed/authors-default.html  # Open that default view in Vim

touch embed/authors-page.html  # Manually create a page view
vim embed/authors-page.html  # Open the page view in Vim
```