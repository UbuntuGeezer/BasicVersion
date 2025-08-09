README - Procs-Dev folder documentation.<br>
5/22/24.	wmk.
<h3>Modification History.</h3><pre><code>
5/22/24.	wmk.	(automated) Modification History sorted.
11/19/23.	wmk.	Intersystem Migration section added; hyperlinks adapted for 
11/19/23.	 Lenovo (CB1) system. 
9/4/23.     wmk.	original document. 
</code></pre>
<h3 id="IX">Document Sections.</h3>
<pre><code><a href="#1.0">link</a> 1.0 Project Description - overall project description.
<a href="#2.0">link</a> 2.0 Dependencies - project dependencies.
<a href="#3.0">link</a> 3.0 Folders Shell - the folders.sh shell setup for cd.* commands.
<a href="#4.0">link</a> 4.0 Intersystem Migration - migrating the Territory system to other systems.
<a href="#5.0">link</a> 5.0 Significant Notes - important stuff not documented elsewhere.
</code></pre>
<h3 id="1.0">1.0 Project Description.</h3>
Procs-Dev contains shells that apply across the Basic subsystem.
These general purpose shells are coded to work on any
folder within the Basic system.

The folders.sh shell is required to be
present in the Procs-Dev folder. This shell provides function definitions for
pseudo-commands that change folders within the Basic system. When a
Terminal session starts up and is going to work in the Basic subsystem,
invoking the 'chsubsys' alias  should be used to switch to the Basic subsystem
and invoke the Procs-Dev/folders.sh shell. That will facilitate proper execution
of various
"cd" commands to change folders within the Basic System.
(See the <a href="#3.0">Folders Shell.</a> section below.)
<a href="#IX">Index</a>
#===========================================================================
<h3 id="2.0">2.0 Dependencies.</h3>
<a href="#IX">Index</a>
#===========================================================================
<h3 id="3.0">3.0 Folders Shell.</h3>
<!-- needs updating for Basic -->
The folders.sh shell provides function definitions to facilitate changing
working directories within a congregation territory. Since a congregation's
territory may span counties, or even states, any congregation that has that
situation will need to have several county/state-specific code and data
folders. By having a folders.sh shell to provide pseudo-commands for changing
working directories within that territory segment, the same commands may be
used regardless of which territory segment is being worked on.

A congregation territory "segment" is for a specific state, county and
congregation number. Most congregation territories are only one segment, not
crossing any county or state boundaries. For those that have more than one
segment, each segment is identified by < state >< county >< congno > where
< state > is the two-character state, < county > is the four-character county,
and < congo > is the congregation number.

Each segment has its own code and data paths that use those three elements. The
code segment uses the folder TerritoriesCB/< segment > as the parent folder for
all code and build operations. The data segment uses the folder
Territories/< segdata-path > as the parent folder for all the publisher
territory data for that segment. For example: the < segment > for the
Florida, Sarasota county, congregation # 86777 is "FLsara86777". The
< segdata-path > is "Territories/FL/SARA/86777".

folders.sh for any given territory segment should contain the following functions:
<pre><code>
 cda - change to TerritoriesCB/< segment > folder.
 cdab - change to Projects-Geany/< segment >/ArchivingBackups project folder.
 cdc - change to Territories/< segdata-path >
 cdd - change to Territories/< segdata-path >/DB-Dev
 cdg - change to TerritoriesCB/< segment >/*P1 project folder.
 cdj - change to TerritoriesCB/< segment >/*P1 project folder.
 cdp - change to TerritoriesCB/Procs-Dev folder."
 cdt - change to Territories/< segdata-path >/RawData../RefUSA-Downloads folder."
 cdts - change to Territories/< segdata-path >/RawData../RefUSA-Download/Special folder."
 cds - change to Territories/<segdata-path>/RawData../SCPA-Downloads folder."
 cdss - change to Territories/<segdata-path>/RawData../SCPA-Downloads/Special folder."
 huh - list this list to terminal."
</code></pre>
When the *source command is issued using the folders.sh shell, all of the above
function definitions become valid command lines.
<br><a href="#IX">Index</a>
#===========================================================================
<h3 id="4.0">4.0 Intersystem Migration.</h3>
The Procs-Dev folder is essential for migrating the Territory system between
development computer systems. The code segment paths are distinct between
development systems due to operating system root path differences. The Procs-Dev
folder contains key shells to expedite the migration process. A migration must
be performed whenever the Territory system is cloned on a new development system
or when the build version of any of the pieces of the Territory system has been
advanced.

The general outline of steps to perform when migrating the Territory system to a
different development system are as follows:
<pre><code>
    migrate the Procs-Dev shell files
    migrate the TerrVersion *git project, advancing the current CB version cycle
    run the TerrVersion (master) *git project:
        run IncCyc.sh cb to advance the CB cycle
        run SetVersion.sh master to update the *master branch
        push the *master branch up to GitHub
        run 'SetVersion.sh Lenovo cb -f' to update the *Lenovo branch
        push the *Lenovo branch up to GitHub
    on each Projects-Geany project:
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the .sh files
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the Make.* files
        create a new Version.i.j.k file with 'k' as the new CB version cycle
    for SCPA-Downloads/Special
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the .sh files
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the Make.* files
        create a new Version.i.j.k file with 'k' as the new CB version cycle
    for each SCPA-Downloads territory:
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the .sh files
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the Make.* files
        create a new Version.i.j.k file with 'k' as the new CB version cycle
    for RefUSA-Downloads/Special
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the .sh files
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the Make.* files
        create a new Version.i.j.k file with 'k' as the new CB version cycle
    for each RefUSA-Downloads territory:
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the .sh files
        use the Kill.* and UnKill.* Procs-Dev shells to migrate the Make.* files
        use the AnySQLtoSH project to regenerate SQL-dependent shells
</code></pre>
Once Procs-Dev and TerrVersion have been migrated, the Projects-Geany projects
should be migrated in prioritized order because of interproject dependencies.
For documentation on the depenedencies and the preferred order of migration, see
the [Projects-Geany](file:///media/fuse/crostini_67db2e155275fc7e48975519462d5b22a040848a_termina_penguin/GitHub/TerrCode86777/FLsara86777cb/Projects-Geany/README.html#2.0) documentation.
<h3 id="5.0">5.0 Significant Notes.</h3>
