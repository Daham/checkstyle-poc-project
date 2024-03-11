#!/usr/bin/perl

$command = "git-diff-index --cached HEAD 2>&1 | sed 's/^:.*     //' | uniq";
open (FILES,$command . "|") || die "Cannot run '$command': $!\n";

$CONFIG_CHECK_FILE = "checkstyle.checkfile";
$CONFIG_JAR = "checkstyle.jar";
$CONFIG_JAVA = "java.command";

$check_file = `git config --get $CONFIG_CHECK_FILE`;
$checkstyle_jar = `git config --get $CONFIG_JAR`;
$java_command = `git config --get $CONFIG_JAVA`;

if (!$check_file || !$checkstyle_jar)
{
   die "You must configure checkstyle in your git config:\n"
   . "\t$CONFIG_CHECK_FILE - path to your checkstyle.xml file\n"
   . "\t$CONFIG_JAR - path to your checkstyle jar file\n"
   . "\t$CONFIG_JAVA - path to your java executable (optional)\n"
   ;
}

$java_command = "java" if (!$java_command);

chomp $check_file;
chomp $checkstyle_jar;
chomp $java_command;

$command = "$java_command -jar $checkstyle_jar -c $check_file";

@java_files = ();

foreach (<FILES>)
{
   chomp;
   next if (!(/\.java$/));
   push @java_files,$_;
   $command .= " ";
   $command .= $_;
}
if ($#java_files >= 0)
{
   if (&run_and_log_system ($command))
   {
       print STDERR "Commit aborted.\n";
       exit -1;
   }
}

print STDERR "Commit aborted.\n";
exit -1;

sub run_and_log_system
{
   ($cmd) = @_;

   system $cmd;
}