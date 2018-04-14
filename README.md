Puppet
======

Organization
------------

### Roles
A role is a single "this is a X computer" purpose. A PC should have 
no more than one role. Roles should not include other roles. Some examples:

* ```role::camper::web```
* ```role::camper::java```
* ```role::camper::pyle```

Every role needs to inherit from ```role::camper::base ``` as this includes
the common stuff to every role and operating-system defaults. Roles are made up of...

### Profiles
Profiles are a single logical unit for a feature. Profiles can include
or depend on other profiles. Examples include:

* ```profile::browsers::chrome```
* ```profile::ide::pycharm```
* ```profile::games::starcraft```

Normally profiles cobble together modules and misc other manifest-y stuff
to complete a feature. But since most of the modules out there don't
support Windows we're gonna need to put that logic in the profiles.

In general a common profile looks like this:
```puppet
class profile::category::feature {
    case $::osfamily {
        'windows': {
            include profile::category::feature::windows
        }
        default: { }
    }
    
    package_name = $::osfamily ? {
        'windows' => 'feature-win',
        'fedora' => 'feature-fc27',
        default   => fail('Unsupported OS')
    }
    
    package { $package_name: }
}
```
Some notes on this example:
1) Platform-specific addons, shortcuts, and other tweaks should go
in a subclass (shown here as ```profile::category::feature::windows```).
2) You can set a variable by case if it's different per-platform.
3) The default ```ensure``` for the ```package {}``` resource is set with those
other OS-defaults mentioned in Roles. You could specify all that stuff here,
but this saves some time.

### Modules
Modules provide specific functions and components. These are commonly
acquired from the [Puppet Forge](https://forge.puppet.com/) or developed
internally. In order to apply appropriate code to enable Forge modules, the
"right" thing to do is contribute these changes upstream. But since
doing open sauce contributions is hard and often takes longer than we
have time for, the next "right" thing to do is fork the upstream repo and
apply our changes there. But that introduces complications in that now we
have to apply any upstream patches to our own repo. Bleh. IMO lets just
keep it simple and either Forge-ify them or do a simple install or whatever
in the Profiles.