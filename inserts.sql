-- =====================================
-- INSERTS PARA TESTE DO BANCO STREAMING
-- =====================================

USE streaming;

-- USUARIO
INSERT INTO usuario (nome, email)
VALUES
('Victoria', 'victoria@email.com');

-- ASSINATURA
INSERT INTO assinatura (plano, usuario_id)
VALUES
('Premium', 1);

-- PERFIS
INSERT INTO perfil (apelido, usuario_id)
VALUES
('Victoria Principal', 1),
('Perfil Infantil', 1);

-- CONTEUDOS
INSERT INTO conteudo (titulo)
VALUES
('Vingadores'),
('Breaking Bad');

-- FILME (Conteúdo ID = 1)
INSERT INTO filme (id)
VALUES
(1);

-- SERIE (Conteúdo ID = 2)
INSERT INTO serie (id)
VALUES
(2);

-- EPISODIOS DA SÉRIE BREAKING BAD
INSERT INTO episodio (titulo, serie_id)
VALUES
('Piloto', 2),
('Gato na Mochila', 2),
('And the Bag''s in the River', 2);

-- CATEGORIAS
INSERT INTO categoria (nome)
VALUES
('Ação'),
('Drama'),
('Crime');

-- RELACIONAMENTO CONTEUDO x CATEGORIA
INSERT INTO conteudo_categoria (conteudo_id, categoria_id)
VALUES
(1, 1),
(2, 2),
(2, 3);

-- AVALIACOES
INSERT INTO avaliacao (
    nota,
    comentario,
    perfil_id,
    conteudo_id
)
VALUES
(10, 'Excelente filme', 1, 1);

INSERT INTO avaliacao (
    nota,
    comentario,
    perfil_id,
    conteudo_id
)
VALUES
(9, 'Muito boa', 2, 2);

-- TESTE DE CASCATA
-- Execute manualmente se desejar:
-- DELETE FROM usuario WHERE id = 1;
