To find packages recursively:

packages=setuptools.find_packages(include=["package", "package.*"]),

To install:

pip install git+ssh://git@gitlab.com/kosciej/pip-test#egg=package_name[extras]
