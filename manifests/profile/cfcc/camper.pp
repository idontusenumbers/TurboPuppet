#
# Common things that define a camper PC. System tools and the like.
# You'll note there is no explicit ordering here. Every profile should
# be independent of the others. If it is not, you should re-evaluate
# your life choices.
#
class profile::cfcc::camper {

    # OS-specific
    case $::kernel {
        'windows': {
            # Platform things
            include profile::firewall::windows
            include profile::winrm::server
            include profile::windows::rdp::enable
            include profile::windows::explorer
            include profile::windows::power
            include profile::windows::xbox::disable
            include profile::windows::update

            # OS-specific System 3rd Party Tools
            include profile::mdns::bonjour
            include profile::tools::spacemonger

            # OS-specific Camper Tools
            include profile::tools::ccleaner
            include profile::tools::notepadplusplus
            include profile::tools::mobaxterm
        }
        'Linux': {
            include profile::mdns::avahi
            # @TODO include profile::firewall::linux
            # @TODO include profile::ssh::server
            include profile::tools::vim
            include profile::tools::sublime
            # @TODO include profile::linux::windowmanager
        }
        default: {}
    }

    # System stuff
    include profile::puppet::agent::disable

    # Camper Tools
    include profile::browsers::chrome
    include profile::browsers::firefox
    include profile::tools::git

    # Games
    include profile::games::quake3
    include profile::games::steam
    include profile::games::minecraft
}