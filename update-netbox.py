# python script.py -f 2.9.9 -t 2.9.10 
# v2.6.11 -> v2.11.10
# https://netbox.readthedocs.io/en/stable/release-notes/version-2.11/
import argparse
parser = argparse.ArgumentParser(description="A simple script to help with netbox upgrades")
parser.add_argument("-f",help="Version of netbox youre looking to upgrade FROM ‘ex 2.7.8'")
parser.add_argument("-t",help="Version of netbox youre looking to upgrade TO ‘ex 2.7.9’")

args = parser.parse_args()
goFrom = str(args.f)
goTo = str(args.t)

print ("### BEGIN NETBOX UPGRADE CODE ###")
print ("cd ~")
print ("wget https://github.com/netbox-community/netbox/archive/v" + goTo + ".tar.gz")
print ("sudo tar -xzf v" + goTo + ".tar.gz -C /opt")
print ("sudo ln -sfn /opt/netbox-" + goTo + "/ /opt/netbox")
print ("sudo cp /opt/netbox-" + goFrom + "/local_requirements.txt /opt/netbox/")
print ("sudo cp /opt/netbox-" + goFrom + "/netbox/netbox/configuration.py /opt/netbox/netbox/netbox/")
print ("sudo cp /opt/netbox-" + goFrom + "/netbox/netbox/ldap_config.py /opt/netbox/netbox/netbox/")
print ("sudo cp -pr /opt/netbox-" + goFrom + "/netbox/media/ /opt/netbox/netbox/")
print ("sudo cp -r /opt/netbox-" + goFrom + "/netbox/scripts /opt/netbox/netbox/")
print ("sudo cp -r /opt/netbox-" + goFrom + "/netbox/reports /opt/netbox/netbox/")
print ("sudo cp /opt/netbox-" + goFrom + "/gunicorn.py /opt/netbox/")
print ("sudo /opt/netbox/upgrade.sh")
print ("sudo systemctl restart netbox netbox-rq")
print ("#### END NETBOX UPGRADE CODE ####")
