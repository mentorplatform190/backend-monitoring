SENTRY_AUTH_TOKEN=7e3692ff52cc4195a1cb8e0ecfcee6cd788692be59344843958fa74b1fe67615
SENTRY_ORG=hme-ms
SENTRY_PROJECT=hme-ms
VERSION=`sentry-cli releases propose-version`

deploy: install create_release associate_commits run_django

install:
	pip install -r ./requirements.txt

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
		set-commits $(VERSION) --auto

run_django:
	VERSION=$(VERSION) python manage.py runserver
