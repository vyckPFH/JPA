CREATE DATABASE streaming;
USE streaming;

-- =====================================================
-- USUARIO
-- Entidade principal do sistema.
--
-- Relacionamentos:
-- 1:1 com ASSINATURA
-- 1:N com PERFIL
-- =====================================================

CREATE TABLE usuario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

-- =====================================================
-- ASSINATURA
--
-- Relacionamento 1:1 com USUARIO.
--
-- O campo usuario_id é UNIQUE para garantir
-- que cada usuário tenha apenas uma assinatura.
--
-- ON DELETE CASCADE:
-- Se um usuário for removido,
-- sua assinatura também será removida.
-- =====================================================

CREATE TABLE assinatura (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    plano VARCHAR(50) NOT NULL,

    usuario_id BIGINT UNIQUE,

    CONSTRAINT fk_assinatura_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuario(id)
        ON DELETE CASCADE
);

-- =====================================================
-- PERFIL
--
-- Relacionamento N:1 com USUARIO.
--
-- Um usuário pode possuir vários perfis.
-- Cada perfil pertence a apenas um usuário.
--
-- ON DELETE CASCADE:
-- Ao excluir um usuário,
-- todos os seus perfis serão excluídos.
-- =====================================================

CREATE TABLE perfil (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    apelido VARCHAR(100) NOT NULL,

    usuario_id BIGINT NOT NULL,

    CONSTRAINT fk_perfil_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuario(id)
        ON DELETE CASCADE
);

-- =====================================================
-- CONTEUDO
--
-- Classe pai da herança.
--
-- FILME e SERIE herdam desta tabela.
-- Estratégia equivalente ao
-- InheritanceType.JOINED do JPA.
-- =====================================================

CREATE TABLE conteudo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL
);

-- =====================================================
-- FILME
--
-- Herança de CONTEUDO.
--
-- O mesmo ID do conteúdo é utilizado aqui.
--
-- ON DELETE CASCADE:
-- Se o conteúdo for removido,
-- o registro em FILME também será removido.
-- =====================================================

CREATE TABLE filme (
    id BIGINT PRIMARY KEY,

    CONSTRAINT fk_filme_conteudo
        FOREIGN KEY (id)
        REFERENCES conteudo(id)
        ON DELETE CASCADE
);

-- =====================================================
-- SERIE
--
-- Herança de CONTEUDO.
--
-- ON DELETE CASCADE:
-- Se o conteúdo for removido,
-- a série também será removida.
-- =====================================================

CREATE TABLE serie (
    id BIGINT PRIMARY KEY,

    CONSTRAINT fk_serie_conteudo
        FOREIGN KEY (id)
        REFERENCES conteudo(id)
        ON DELETE CASCADE
);

-- =====================================================
-- EPISODIO
--
-- Relacionamento N:1 com SERIE.
--
-- Uma série possui vários episódios.
-- Um episódio pertence a apenas uma série.
--
-- ON DELETE CASCADE:
-- Ao excluir uma série,
-- todos os seus episódios serão excluídos.
-- =====================================================

CREATE TABLE episodio (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,

    serie_id BIGINT NOT NULL,

    CONSTRAINT fk_episodio_serie
        FOREIGN KEY (serie_id)
        REFERENCES serie(id)
        ON DELETE CASCADE
);

-- =====================================================
-- CATEGORIA
--
-- Relacionamento N:M com CONTEUDO
-- através da tabela conteudo_categoria.
-- =====================================================

CREATE TABLE categoria (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- =====================================================
-- CONTEUDO_CATEGORIA
--
-- Relacionamento N:M.
--
-- Um conteúdo pode possuir várias categorias.
-- Uma categoria pode estar em vários conteúdos.
--
-- ON DELETE CASCADE:
-- Ao excluir conteúdo ou categoria,
-- os registros desta tabela são removidos.
-- =====================================================

CREATE TABLE conteudo_categoria (
    conteudo_id BIGINT,
    categoria_id BIGINT,

    PRIMARY KEY (conteudo_id, categoria_id),

    CONSTRAINT fk_cc_conteudo
        FOREIGN KEY (conteudo_id)
        REFERENCES conteudo(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cc_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categoria(id)
        ON DELETE CASCADE
);

-- =====================================================
-- AVALIACAO
--
-- Relacionamento N:1 com PERFIL.
-- Relacionamento N:1 com CONTEUDO.
--
-- Um perfil pode fazer várias avaliações.
-- Um conteúdo pode receber várias avaliações.
--
-- ON DELETE CASCADE:
-- Ao excluir um perfil ou conteúdo,
-- suas avaliações serão removidas.
-- =====================================================

CREATE TABLE avaliacao (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nota INT NOT NULL,
    comentario TEXT,

    perfil_id BIGINT NOT NULL,
    conteudo_id BIGINT NOT NULL,

    CONSTRAINT fk_avaliacao_perfil
        FOREIGN KEY (perfil_id)
        REFERENCES perfil(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_avaliacao_conteudo
        FOREIGN KEY (conteudo_id)
        REFERENCES conteudo(id)
        ON DELETE CASCADE
);
