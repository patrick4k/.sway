#!/usr/bin/env perl
# Usage: ws-cycle.pl <workspace>
# Switch to <workspace>; if already there, focus the next window on it
# (tiling + floating, in tree order), wrapping around.
use strict;
use warnings;
use JSON::PP;

my $target = shift // die "usage: $0 <workspace>\n";

sub sway_json { decode_json(scalar qx(swaymsg -r -t $_[0])) }

my ($current) = map { $_->{name} } grep { $_->{focused} } @{ sway_json('get_workspaces') };

if (!defined $current || $current ne $target) {
    system('swaymsg', '-q', 'workspace', $target);
    exit;
}

# Find the target workspace node in the tree
sub find_ws {
    my ($node) = @_;
    return $node if ($node->{type} // '') eq 'workspace' && $node->{name} eq $target;
    for (@{ $node->{nodes} }, @{ $node->{floating_nodes} // [] }) {
        my $found = find_ws($_);
        return $found if $found;
    }
    return;
}

# Collect leaf windows (no children) in tree order
sub leaves {
    my ($node) = @_;
    my @kids = (@{ $node->{nodes} }, @{ $node->{floating_nodes} // [] });
    return $node if !@kids && $node->{type} =~ /^(?:con|floating_con)$/;
    return map { leaves($_) } @kids;
}

my $ws = find_ws(sway_json('get_tree')) or exit;
my @wins = leaves($ws) or exit;

my ($i) = grep { $wins[$_]{focused} } 0 .. $#wins;
my $next = $wins[ defined $i ? ($i + 1) % @wins : 0 ];

system('swaymsg', '-q', "[con_id=$next->{id}] focus");
