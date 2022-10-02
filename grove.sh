if [ $1 == 'init' ]; then
	git clone https://github.com/CouchCMS/CouchCMS && mv CouchCMS/couch ./ && rm -rf CouchCMS && cp couch/config.example.php couch/config.php
	mkdir assets && touch assets/main.css assets/main.js
	mkdir embed && mkdir embed/forms embed/partials embed/template embed/vars
	touch vars/globals.html
	for item in config-form config-list editables routes; do
		mkdir embed/template/$item
	done
fi


if [ $1 == 'template' ]; then
	if [ ! -f $2.php ]; then
		title="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
		echo "<?php require_once('couch/cms.php');?>

<cms:template title='$title'>
	<cms:embed \"template/editables/<cms:show k_template_name />.html\" />
	<cms:embed \"template/config-form/<cms:show k_template_name />.html\" />
	<cms:embed \"template/config-list/<cms:show k_template_name />.html\" />
	<cms:embed \"template/routes/<cms:show k_template_name />.html\" />
</cms:template>

<cms:smart_embed />

<?php COUCH::invoke();?>" >> $2.php
	fi
	touch embed/template/config-form/$2.html
	touch embed/template/config-list/$2.html
	touch embed/template/editables/$2.html
	touch embed/template/routes/$2.html
	touch embed/$2-default.html
fi



if [ $1 == 'remove' ]; then
	if [ $2 == 'template' ]; then
		rm $3.php
		for item in config-form config-list editables routes; do
			rm embed/template/$item/$3.html
		done
	fi
fi