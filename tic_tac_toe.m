x = 2.5; y = 2.5; z = 2; a=zeros(1, 64); t = 0:0.1:2*pi; win=0; tx=0; ty=0; tz=0;
count=0; checkMate=0; first=0; AIx=0; AIy=0; AIz=0; AIdir=1; put=0; can=0;
%initial figure
figure
axis([1, 5, 1, 5, 1, 4])
view(-75, 15)
axis off
title('Move:wasdrf  Put:z', 'FontSize', 12) %how to play
for i=1:4
  for j=1:5
    line([1, 5], [j, j], [i, i], 'LineWidth', 2) %draw line to form grid
    line([j, j], [1, 5], [i, i], 'LineWidth', 2)
  end
end

hold on
point = plot3(x, y, z, 'k.', 'MarkerSize', 20); %the pointer point to where you are now
hold off

while win==0 %keep until player or AI win
  hold on
  waitforbuttonpress %wait button press
  k = get(gcf, 'currentcharacter'); %get button press
  if (k=='w' || k=='W') && x < 4 %forward
    delete(point)
    x = x + 1;
    point = plot3(x, y, z, 'k.', 'MarkerSize', 20); %move pointer
  elseif (k=='s' || k=='S') && x > 2 %backward
    delete(point)
    x = x - 1;
    point = plot3(x, y, z, 'k.', 'MarkerSize', 20);
  elseif (k=='a' || k=='A') && y < 4 %left
    delete(point)
    y = y + 1;
    point = plot3(x, y, z, 'k.', 'MarkerSize', 20);
  elseif (k=='d' || k=='D') && y > 2 %right
    delete(point)
    y = y - 1;
    point = plot3(x, y, z, 'k.', 'MarkerSize', 20);
  elseif (k=='r' || k=='R') && z < 4 %up
    delete(point)
    z = z + 1;
    point = plot3(x, y, z, 'k.', 'MarkerSize', 20);
  elseif (k=='f' || k=='F') && z > 1 %down
    delete(point)
    z = z - 1;
    point = plot3(x, y, z, 'k.', 'MarkerSize', 20);
  elseif (k=='z' || k=='Z') && a(fix(x) + (fix(y)-1)*4 + (z-1)*16)==0 %put the marker if there is no marker on the grid
    tx = fix(x); ty = (fix(y)-1)*4; tz=(z-1)*16;
    a(tx + ty + tz) = 1; %set player marker
    plot3(0.3*cos(t)+x, 0.3*sin(t)+y, z * ones(1, 63), 'LineWidth', 2, 'color', 'b') %draw circle
    
    checkMate = 0; %checkMate != 0 represent player is going to win
    %below is to check the thirteen direction to see if there is three marker on the same direction
    %if there is, then change the checkMate value to the direction
    %at the same time, check if the player wins.
    %If player wins, then the game is over and AI doesn't need to put marker
    count = 0;
    for i=1:4
      if a(i + ty + tz)==1 %if find a player marker
        count = count + 1;
      elseif a(i + ty + tz)==2 %if find a AI marker
        count = count - 1;
      end
    end
    if count == 4 %marker 4 means win
      win = 1;
    elseif count==3 %marker 3 means checkMate
      checkMate = 1;
    end
    
    count = 0;
    for i=0:3
      if a(tx + i*4 + tz)==1
        count = count + 1;
      elseif a(tx + i*4 + tz)==2
        count = count - 1;
      end
    end
    if count == 4
      win = 1;
    elseif count==3
      checkMate = 2;
    end
    
    count = 0;
    for i=0:3
      if a(tx + ty + i*16)==1
        count = count + 1;
      elseif a(tx + ty + i*16)==2
        count = count - 1;
      end
    end
    if count == 4
      win = 1;
    elseif count==3
      checkMate = 3;
    end
    
    if tx == (ty/4)+1
      count = 0;
      for i=1:4
        if a(i + (i-1)*4 + tz)==1
          count = count + 1;
        elseif a(i + (i-1)*4 + tz)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 4;
      end
    end
    
    %the directions below all have some limit, so check the limit first
    if tx+(ty/4)==4
      count = 0;
      for i=0:3
        if a(4-i + i*4 + tz)==1
          count = count + 1;
        elseif a(4-i + i*4 + tz)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 5;
      end
    end  
    
    if tx == (tz/16)+1
      count = 0;
      for i=1:4
        if a(i + ty + (i-1)*16)==1
          count = count + 1;
        elseif a(i + ty + (i-1)*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 6;
      end
    end
    
    if tx+(tz/16)==4
      count = 0;
      for i=0:3
        if a(4-i + ty + i*16)==1
          count = count + 1;
        elseif a(4-i + ty + i*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 7;
      end
    end
    
    if ty/4 == tz/16
      count = 0;
      for i=0:3
        if a(tx + i*4 + i*16)==1
          count = count + 1;
        elseif a(tx + i*4 + i*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 8;
      end
    end
    
    if (ty/4)+(tz/16)==3
      count = 0;
      for i=0:3
        if a(tx + (3-i)*4 + i*16)==1
          count = count + 1;
        elseif a(tx + (3-i)*4 + i*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 9;
      end
    end
    
    if tx==(ty/4)+1 && tx==(tz/16)+1
      count = 0;
      for i=1:4
        if a(i + (i-1)*4 + (i-1)*16)==1
          count = count + 1;
        elseif a(i + (i-1)*4 + (i-1)*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 10;
      end
    end
    
    if tx==(ty/4)+1 && tx+(tz/16)==4
      count = 0;
      for i=1:4
        if a(i + (i-1)*4 + (4-i)*16)==1
          count = count + 1;
        elseif a(i + (i-1)*4 + (4-i)*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 11;
      end
    end
    
    if tx+(ty/4)==4 && tx==(tz/16)+1
      count = 0;
      for i=1:4
        if a(i + (4-i)*4 + (i-1)*16)==1
          count = count + 1;
        elseif a(i + (4-i)*4 + (i-1)*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 12;
      end
    end
    
    if tx+(ty/4)==4 && tx+(tz/16)==4
      count = 0;
      for i=1:4
        if a(i + (4-i)*4 + (4-i)*16)==1
          count = count + 1;
        elseif a(i + (4-i)*4 + (4-i)*16)==2
          count = count - 1;
        end
      end
      if count == 4
        win = 1;
      elseif count==3
        checkMate = 13;
      end
    end %end of player check

    %if it is first round, then AI put marker in the one of the eight middle grids randomly
    if first==0
      first = 1;
      random = randi(8, 1);
      
      if random == 1
        if a(22)==0
          a(22) = 2;
          AIx=2; AIy=4; AIz=16; can=22;
        else
          random = 2;
        end
      end
      
      if random == 2
        if a(23)==0
          a(23) = 2;
          AIx=3; AIy=4; AIz=16; can=23;
        else
          random = 3;
        end
      end
      
      if random == 3
        if a(26)==0
          a(26) = 2;
          AIx=2; AIy=8; AIz=16; can=26;
        else
          random = 4;
        end
      end
      
      if random == 4
        if a(27)==0
          a(27) = 2;
          AIx=3; AIy=8; AIz=16; can=27;
        else
          random = 5;
        end
      end
      
      if random == 5
        if a(38)==0
          a(38) = 2;
          AIx=2; AIy=4; AIz=32; can=38;
        else
          random = 6;
        end
      end
      
      if random == 6
        if a(39)==0
          a(39) = 2;
          AIx=3; AIy=4; AIz=32; can=39;
        else
          random = 7;
        end
      end
      
      if random == 7
        if a(42)==0
          a(42) = 2;
          AIx=2; AIy=8; AIz=32; can=42;
        else
          random = 8;
        end
      end
      
      if random == 8
        if a(43)==0
          a(43) = 2;
          AIx=3; AIy=8; AIz=32; can=43;
        else
          a(22) = 2;
          AIx=2; AIy=4; AIz=16; can=22;
        end
      end
      %draw forks
      plot3([AIx, AIx+1],[(AIy/4)+1, (AIy/4)+2], [(AIz/16)+1, (AIz/16)+1], 'LineWidth', 2, 'color', 'r')
      plot3([AIx, AIx+1],[(AIy/4)+2, (AIy/4)+1], [(AIz/16)+1, (AIz/16)+1], 'LineWidth', 2, 'color', 'r')

    elseif win == 1 %if the player wins, pop out a message block to congratulation
      warndlg('Congratulations! You win!', 'Win!');
      title('You win!', 'FontSize', 12);
      
    else %if player doesn't win and it is not first round
      %if there is no checkMate, which means AI normal mode
      %normal mode means to put marker on the same direction as the last round in normal mode
      if checkMate == 0
        put = 0; %check if finding a empty grid
        %get the three element from last round in normal mode
        AIz = fix((can-1)/16)*16;
        AIy = fix((can-AIz-1)/4)*4;
        AIx = can - AIz - AIy;
        %iterate two times to go through all direction
        %if find a OK direction, set put to 1 and break
        for i=1:2
          
          if AIdir == 1
            for j=1:4
              if a(j + AIy + AIz) == 0 %empty grid
                can = j + AIy + AIz; %can means candidate grid
              elseif a(j + AIy + AIz) == 1
                AIdir = 2; %if there is a player's marker, change direction
              end
            end
            %if direction is not change, then AI can put marker at candidate on this direction
            if AIdir == 1
              put = 1;
              break
            end
          end
          
          %below is similar to first one, so I don't explain again
          if AIdir == 2
            for j=0:3
              if a(AIx + j*4 + AIz) == 0
                can = AIx + j*4 + AIz;
              elseif a(AIx + j*4 + AIz) == 1
                AIdir = 3;
              end
            end
            if AIdir == 2
              put = 1;
              break
            end
          end
          
          if AIdir == 3
            for j=0:3
              if a(AIx + AIy + j*16) == 0
                can = AIx + AIy + j*16;
              elseif a(AIx + AIy + j*16) == 1
                AIdir = 4;
              end
            end
            if AIdir == 3
              put = 1;
              break
            end
          end
          
          if AIdir == 4
            if AIx == (AIy/4)+1
              for j=1:4
                if a(j + (j-1)*4 + AIz) == 0
                  can = j + (j-1)*4 + AIz;
                elseif a(j + (j-1)*4 + AIz) == 1
                  AIdir = 5;
                end
              end
              if AIdir == 4
                put = 1;
                break
              end
            else
              AIdir = 5;
            end
          end
          
          if AIdir == 5
            if AIx + (AIy/4) == 4
              for j=0:3
                if a(4-j + j*4 + AIz) == 0
                  can = 4-j + j*4 + AIz;
                elseif a(4-j + j*4 + AIz) == 1
                  AIdir = 6;
                end
              end
              if AIdir == 5
                put = 1;
                break
              end
            else
              AIdir = 6;
            end
          end
          
          if AIdir == 6
            if AIx == (AIz/16)+1
              for j=1:4
                if a(j + AIy + (j-1)*16) == 0
                  can = j + AIy + (j-1)*16;
                elseif a(j + AIy + (j-1)*16) == 1
                  AIdir = 7;
                end
              end
              if AIdir == 6
                put = 1;
                break
              end
            else
              AIdir = 7;
            end
          end
          
          if AIdir == 7
            if AIx + (AIz/16) == 4
              for j=0:3
                if a(4-j + AIy + j*16) == 0
                  can = 4-j + AIy + j*16;
                elseif a(4-j + AIy + j*16) == 1
                  AIdir = 8;
                end
              end
              if AIdir == 7
                put = 1;
                break
              end
            else
              AIdir = 8;
            end
          end
          
          if AIdir == 8
            if AIy/4 == AIz/16
              for j=0:3
                if a(AIx + j*4 + j*16) == 0
                  can = AIx + j*4 + j*16;
                elseif a(AIx + j*4 + j*16) == 1
                  AIdir = 9;
                end
              end
              if AIdir == 8
                put = 1;
                break
              end
            else
              AIdir = 9;
            end
          end
          
          if AIdir == 9
            if AIy/4 + AIz/16 == 3
              for j=0:3
                if a(AIx + (3-j)*4 + j*16) == 0
                  can = AIx + (3-j)*4 + j*16;
                elseif a(AIx + (3-j)*4 + j*16) == 1
                  AIdir = 10;
                end
              end
              if AIdir == 9
                put = 1;
                break
              end
            else
              AIdir = 10;
            end
          end
          
          if AIdir == 10
            if AIx == (AIy/4)+1 && AIx == (AIz/16)+1
              for j=1:4
                if a(j + (j-1)*4 + (j-1)*16) == 0
                  can = j + (j-1)*4 + (j-1)*16;
                elseif a(j + (j-1)*4 + (j-1)*16) == 1
                  AIdir = 11;
                end
              end
              if AIdir == 10
                put = 1;
                break
              end
            else
              AIdir = 11;
            end
          end
          
          if AIdir == 11
            if AIx == (AIy/4)+1 && AIx + (AIz/16) == 4
              for j=1:4
                if a(j + (j-1)*4 + (4-j)*16) == 0
                  can = j + (j-1)*4 + (4-j)*16;
                elseif a(j + (j-1)*4 + (4-j)*16) == 1
                  AIdir = 12;
                end
              end
              if AIdir == 11
                put = 1;
                break
              end
            else
              AIdir = 12;
            end
          end
          
          if AIdir == 12
            if AIx + (AIy/4) == 4 && AIx == (AIz/16)+1
              for j=1:4
                if a(j + (4-j)*4 + (j-1)*16) == 0
                  can = j + (4-j)*4 + (j-1)*16;
                elseif a(j + (4-j)*4 + (j-1)*16) == 1
                  AIdir = 13;
                end
              end
              if AIdir == 12
                put = 1;
                break
              end
            else
              AIdir = 13;
            end
          end
          
          if AIdir == 13
            if AIx + (AIy/4) == 4 && AIx + (AIz/16) == 4
              for j=1:4
                if a(j + (4-j)*4 + (4-j)*16) == 0
                  can = j + (4-j)*4 + (4-j)*16;
                elseif a(j + (4-j)*4 + (4-j)*16) == 1
                  AIdir = 1;
                end
              end
              if AIdir == 13
                put = 1;
                break
              end
            else
              AIdir = 1;
            end
          end
        end %end of normal AI mode
        %if there is all blocked by player, go through all grid to find a empty grid
        if put==0 
          for i=1:64
            if a(i)==0
              can = i;
            end
          end
        end
        a(can) = 2; %set the grid to AI marker
        %give the value to the three elements, let them to draw forks
        AIz = fix((can-1)/16)*16;
        AIy = fix((can-AIz-1)/4)*4;
        AIx = can - AIz - AIy;
        
      %below is AI block mode
      %means player is going to win(checkMate), so AI need to block player
      elseif checkMate == 1
        for i=1:4
          if a(i + ty + tz)==0 %find the empty grid and put marker on to it
            a(i + ty + tz) = 2; %put AI marker
            AIx = i; AIy = ty; AIz = tz; %give value to the three elements
            break
          end
        end
        
      %below is similar to first one, so I don't explain again
      elseif checkMate == 2
        for i=0:3
          if a(tx + i*4 + tz)==0
            a(tx + i*4 + tz) = 2;
            AIx = tx; AIy = i*4; AIz = tz;
            break
          end
        end
        
      elseif checkMate == 3
        for i=0:3
          if a(tx + ty + i*16)==0
            a(tx + ty + i*16) = 2;
            AIx = tx; AIy = ty; AIz = i*16;
            break
          end
        end
        
      elseif checkMate == 4
        for i=1:4
          if a(i + (i-1)*4 + tz)==0
            a(i + (i-1)*4 + tz) = 2;
            AIx = i; AIy = (i-1)*4; AIz = tz;
            break
          end
        end
    
      elseif checkMate == 5
        for i=0:3
          if a(4-i + i*4 + tz)==0
            a(4-i + i*4 + tz) = 2;
            AIx = 4-i; AIy = i*4; AIz = tz;
            break
          end
        end
        
      elseif checkMate == 6
        for i=1:4
          if a(i + ty + (i-1)*16)==0
            a(i + ty + (i-1)*16) = 2;
            AIx = i; AIy = ty; AIz = (i-1)*16;
            break
          end
        end
        
      elseif checkMate == 7
        for i=0:3
          if a(4-i + ty + i*16)==0
            a(4-i + ty + i*16) = 2;
            AIx = 4-i; AIy = ty; AIz = i*16;
            break
          end
        end
        
      elseif checkMate == 8
        for i=0:3
          if a(tx + i*4 + i*16)==0
            a(tx + i*4 + i*16) = 2;
            AIx = tx; AIy = i*4; AIz = i*16;
            break
          end
        end
    
      elseif checkMate == 9
        for i=0:3
          if a(tx + (3-i)*4 + i*16)==0
            a(tx + (3-i)*4 + i*16) = 2;
            AIx = tx; AIy = (3-i)*4; AIz = i*16;
            break
          end
        end
    
      elseif checkMate == 10
        for i=1:4
          if a(i + (i-1)*4 + (i-1)*16)==0
            a(i + (i-1)*4 + (i-1)*16) = 2;
            AIx = i; AIy = (i-1)*4; AIz = (i-1)*16;
            break
          end
        end
    
      elseif checkMate == 11
        for i=1:4
          if a(i + (i-1)*4 + (4-i)*16)==0
            a(i + (i-1)*4 + (4-i)*16) = 2;
            AIx = i; AIy = (i-1)*4; AIz = (4-i)*16;
            break
          end
        end
    
      elseif checkMate == 12
        for i=1:4
          if a(i + (4-i)*4 + (i-1)*16)==0
            a(i + (4-i)*4 + (i-1)*16) = 2;
            AIx = i; AIy = (4-i)*4; AIz = (i-1)*16;
            break
          end
        end
    
      elseif checkMate == 13
        for i=1:4
          if a(i + (4-i)*4 + (4-i)*16)==0
            a(i + (4-i)*4 + (4-i)*16) = 2;
            AIx = i; AIy = (4-i)*4; AIz = (4-i)*16;
            break
          end
        end
      end %end of AI block mode
      %draw forks
      plot3([AIx, AIx+1],[(AIy/4)+1, (AIy/4)+2], [(AIz/16)+1, (AIz/16)+1], 'LineWidth', 2, 'color', 'r')
      plot3([AIx, AIx+1],[(AIy/4)+2, (AIy/4)+1], [(AIz/16)+1, (AIz/16)+1], 'LineWidth', 2, 'color', 'r')
      
      %below is going to check if the AI wins, it is similar to how I check if the player wins
      %but just need to look for four marker because I don't care if AI checkMate
      count = 0;
      for i=1:4
        if a(i + AIy + AIz)==2 %find AI marker
          count = count + 1;
        end
      end
      if count == 4 %four AI marker, means AI wins
        win = 2;
      end
      
      %below is similar to first one, so I don't explain again
      count = 0;
      for i=0:3
        if a(AIx + i*4 + AIz)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
      
      count = 0;
      for i=0:3
        if a(AIx + AIy + i*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
      
      count = 0;
      for i=1:4
        if a(i + (i-1)*4 + AIz)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=0:3
        if a(4-i + i*4 + AIz)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
      
      count = 0;
      for i=1:4
        if a(i + AIy + (i-1)*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=0:3
        if a(4-i + AIy + i*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=0:3
        if a(AIx + i*4 + i*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
      
      count = 0;
      for i=0:3
        if a(AIx + (3-i)*4 + i*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=1:4
        if a(i + (i-1)*4 + (i-1)*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=1:4
        if a(i + (i-1)*4 + (4-i)*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=1:4
        if a(i + (4-i)*4 + (i-1)*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
    
      count = 0;
      for i=1:4
        if a(i + (4-i)*4 + (4-i)*16)==2
          count = count + 1;
        end
      end
      if count == 4
        win = 2;
      end
      
      if win==2 %if AI wins, pop out lose message
        warndlg('Sorry! You lose!', 'Lose!');
        title('You lose!', 'FontSize', 12);
      end
      
    end
    
  end
  hold off
  shg
end
clear