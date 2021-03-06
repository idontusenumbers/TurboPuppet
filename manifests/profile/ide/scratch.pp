#
# MIT Scratch
#
class profile::ide::scratch {
    # Since this is a webapp, we'll simply create a desktop shortcut to make
    # finding it easier.

    file { 'scratch icon':
        path   => 'C:\ProgramData\scratch.ico',
        ensure => file,
        source => 'https://scratch.mit.edu/favicon.ico',
    }

    # Specifying an icon causes this to change every time :(
    shortcut { 'C:/Users/Public/Desktop/Scratch.lnk':
        icon_location => 'C:\ProgramData\scratch.ico',
        require       => [ Class['profile::browsers::chrome'], File['scratch icon'] ],
        target        => 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe',
        arguments     => 'https://scratch.mit.edu'
    }
}