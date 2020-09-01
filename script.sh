build_num=33
rm -rf build/ dist/ jfrog_python_example.egg-info/
sed -ie "s/0/$build_num/g" setup.py
jfrog rt pipi -r requirements.txt --build-name=my-pip-build --build-number=$build_num --module=jfrog-python-example --no-cache-dir --force-reinstall
python setup.py sdist bdist_wheel
jfrog rt u dist/ pypi/ --build-name=my-pip-build --build-number=$build_num --module=jfrog-python-example --props=stage=dev
jfrog rt bag my-pip-build $build_num /Users/shanil/Documents/Github/SolEngDemo/ --config issuesCollectionConfig.json
jfrog rt bce my-pip-build $build_num
jfrog rt bp my-pip-build $build_num
jfrog rt bpr my-pip-build $build_num pypi-prod-local --status=Released --comment="Promoting Python Build" --props=stage=prod
jfrog rt bs my-pip-build $build_num
sed -ie "s/$build_num/0/g" setup.py
