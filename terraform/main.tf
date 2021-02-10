terraform {
  required_providers {
    gandi = {
      source  = "psychopenguin/gandi"
      version = "2.0.0-rc3"
    }
  }
}

provider "gandi" {
  key = var.gandi_key
}

data "gandi_domain" "bhscs_club" {
  name = "bhscs.club"
}


# GitHub Pages website
resource "gandi_livedns_record" "www_bhscs" {
  zone   = "bhscs.club"
  name   = "www"
  type   = "CNAME"
  values = ["bhscomputerscienceclub.github.io."]
  ttl    = 1800
}

resource "gandi_livedns_record" "A_bhscs" {
  zone = "bhscs.club"
  name = "@"
  type = "A"
  values = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
  ttl = 1800
}

# projects
resource "gandi_livedns_record" "project" {
  zone = "bhscs.club"
  type = "CNAME"
  ttl  = 600

  for_each = var.project_domains

  name   = each.key
  values = ["${each.value.server}.servers"]
}

# Default Mail Stuff

resource "gandi_livedns_record" "MX_root" {
  zone = "bhscs.club"
  name = "@"
  type = "MX"
  values = [
    "10 spool.mail.gandi.net.",
    "50 fb.mail.gandi.net."
  ]
  ttl = 10800
}

resource "gandi_livedns_record" "TXT_mail_root" {
  zone = "bhscs.club"
  name = "@"
  type = "TXT"
  values = [
    "\"v=spf1 include:_mailcust.gandi.net ?all\""
  ]

  ttl = 10800
}

resource "gandi_livedns_record" "CNAME_webmail" {
  zone   = "bhscs.club"
  name   = "webmail"
  type   = "CNAME"
  values = ["webmail.gandi.net."]
  ttl    = 10800

}

resource "gandi_livedns_record" "srv_mail" {
  zone = "bhscs.club"
  type = "SRV"
  ttl  = 10800

  for_each = {
    imap       = "0 0 0   ."
    imaps      = "0 1 993 mail.gandi.net."
    pop3       = "0 0 0   ."
    pop3s      = "10 1 995 mail.gandi.net."
    submission = "0 1 465 mail.gandi.net."
  }
  name = "_${each.key}._tcp"
  values = [
    each.value
  ]
}


