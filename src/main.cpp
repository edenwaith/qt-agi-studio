/*
 *  QT AGI Studio :: Copyright (C) 2000 Helen Zommer
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#include <cstdlib>
#include <stdio.h>

#include <qapplication.h>
#include <q3mainwindow.h>

#include "menu.h"
#include "game.h"

QApplication *app;
char tmp[MAX_TMP]; //global temporary buffer

static char help[]=
"QT AGI Studio v1.3.0.\n\
A Sierra On-Line(tm) adventure game creator and editor.\n\
\n\
Usage: agistudio [switches] \n\
\n\
where [switches] are optionally:\n\
\n\
-dir GAMEDIR   : open an existing game in GAMEDIR\n\
-help          : this message\n\
\n";

// Check if the string str is prefixed with the string pre
bool startsWith(const char *pre, const char *str)
{
    size_t lenpre = strlen(pre),
                   lenstr = strlen(str);
    return lenstr < lenpre ? false : strncmp(pre, str, lenpre) == 0;
}

//***************************************************
int main( int argc, char **argv )
{
  char *gamedir=NULL;
  
  tmp[0]=0;

  for(int i=1;i<argc;i++) {

    if (argv[i][0] == '-') {
      if (!strcmp(argv[i]+1,"dir")) {
        gamedir = argv[i+1];
      }
      else
      {
          // On older versions of Mac OS X, launching the app bundle will include
          // a psn argument, like -psn_0_1446241.  Ignore this and break out of
          // this conditional statement so the app will launch.
          if (startsWith("-psn", argv[i])) {
              // printf("Yes, the argument starts with -psn\n");
              break;
          }
        else if(strcmp(argv[i]+1,"help")!=0 && strcmp(argv[i]+1,"-help")!=0) {
          printf( "Unknown parameter %s.\n\n", argv[i]+1 );
          }
        printf(help);
        exit(-2);
      }
    }
  }

  app = new QApplication(argc,argv);
  menu = new Menu(NULL,NULL);
  app->setMainWidget( menu );

  game = new Game();

  menu->show();
  
  if(gamedir){
    int err = game->open(gamedir);
    if(!err)menu->show_resources();
  }
  return app->exec();
}
