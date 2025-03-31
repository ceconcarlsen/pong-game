-- Variáveis do jogo
  window_width = 800
  window_height = 600
  paddle_speed = 300
  ball_speed = 250
  
  function love.load()
      -- Define tamanho da janela
      love.window.setMode(window_width, window_height)
      love.window.setTitle("Pong Game")
      
  
      -- Configuração das raquetes
      paddle_width = 10
      paddle_height = 100
  
      left_paddle = { x = 20, y = (window_height / 2) - (paddle_height / 2) }
      right_paddle = { x = window_width - 30, y = (window_height / 2) - (paddle_height / 2) }
  
      -- Configuração da bola
      ball = { x = window_width / 2, y = window_height / 2, width = 10, height = 10, dx = ball_speed, dy = ball_speed }
  end
  
  function love.update(dt)
      -- Movimento das raquetes
      if love.keyboard.isDown("w") then
          left_paddle.y = math.max(0, left_paddle.y - paddle_speed * dt)
      elseif love.keyboard.isDown("s") then
          left_paddle.y = math.min(window_height - paddle_height, left_paddle.y + paddle_speed * dt)
      end
  
      if love.keyboard.isDown("up") then
          right_paddle.y = math.max(0, right_paddle.y - paddle_speed * dt)
      elseif love.keyboard.isDown("down") then
          right_paddle.y = math.min(window_height - paddle_height, right_paddle.y + paddle_speed * dt)
      end
  
      -- Movimento da bola
      ball.x = ball.x + ball.dx * dt
      ball.y = ball.y + ball.dy * dt
  
      -- Colisão da bola com o topo e a base
      if ball.y <= 0 or ball.y >= window_height - ball.height then
          ball.dy = -ball.dy
      end
  
      -- Colisão com as raquetes
      if checkCollision(ball, left_paddle) then
          ball.dx = -ball.dx
          ball.x = left_paddle.x + paddle_width
      elseif checkCollision(ball, right_paddle) then
          ball.dx = -ball.dx
          ball.x = right_paddle.x - ball.width
      end
  
      -- Verifica se a bola saiu da tela (pontos)
      if ball.x < 0 then
          resetBall()
      elseif ball.x > window_width then
          resetBall()
      end
  end
  
  function love.draw()
      -- Desenha as raquetes
      love.graphics.rectangle("fill", left_paddle.x, left_paddle.y, paddle_width, paddle_height)
      love.graphics.rectangle("fill", right_paddle.x, right_paddle.y, paddle_width, paddle_height)
  
      -- Desenha a bola
      love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
  end
  
  -- Função para verificar colisão entre retângulos
  function checkCollision(a, b)
      return a.x < b.x + paddle_width and
             a.x + a.width > b.x and
             a.y < b.y + paddle_height and
             a.y + a.height > b.y
  end
  
  -- Função para resetar a bola no centro
  function resetBall()
      ball.x = window_width / 2
      ball.y = window_height / 2
      ball.dx = -ball.dx  -- Muda a direção ao reiniciar
  end
  