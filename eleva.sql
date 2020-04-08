-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 08-Abr-2020 às 05:30
-- Versão do servidor: 10.4.8-MariaDB
-- versão do PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `eleva`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alunos`
--

CREATE TABLE `alunos` (
  `id` int(11) NOT NULL,
  `nome` varchar(180) NOT NULL,
  `foto` longtext NOT NULL,
  `eid` int(11) NOT NULL,
  `tid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `escolas`
--

CREATE TABLE `escolas` (
  `id` int(11) NOT NULL,
  `escola` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `escolas`
--

INSERT INTO `escolas` (`id`, `escola`) VALUES
(5, 'Pedro II'),
(6, 'Pensi');

-- --------------------------------------------------------

--
-- Estrutura da tabela `turmas`
--

CREATE TABLE `turmas` (
  `id` int(11) NOT NULL,
  `turma` varchar(80) NOT NULL,
  `escola` varchar(180) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `turmas`
--

INSERT INTO `turmas` (`id`, `turma`, `escola`) VALUES
(2, '1001', 'Pedro II');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(180) NOT NULL,
  `password` varchar(180) NOT NULL,
  `email` varchar(180) NOT NULL,
  `file` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `file`) VALUES
(1, 'admin', '55be4112e769a6ea3409434b0e7eb2c3', 'wes.andrade@yahoo.com', '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxISEhUSEBMVFhUXFxcYFRUVFRUXFRcWFhUWFhYYFhYYHSggGBolHRYVITEhJSkrLi4uGB8zODMtNygtLisBCgoKDg0OFxAQFyslHR0tLS0tLS0rLSstLS0tLS0tLS0tLTc3Ky0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSstK//AABEIAOAA4QMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABAUBAgYDB//EAD0QAAIBAgIHBgQDBwQDAQAAAAABAgMRBCEFEjFBUXGBYZGhscHwBiIy0RMj4TNCUoKisvEkYnKSFEPCB//EABgBAQEBAQEAAAAAAAAAAAAAAAABAgME/8QAIBEBAQACAwEAAgMAAAAAAAAAAAECEQMhMUEyURITYf/aAAwDAQACEQMRAD8A+1GQCoAGQAAAAAAAAAAAAAAAAAAAAAAAAMAyAMAyYAAAAAAAAAGQAAAAAAAAAB44jFRht28FtPHFYy2UdvEhxe95shtLp4+/7rS7T1eLRArYmOraTKOWKetaMsuLM3LRHWOvvsarGx7Sroyko75dqNJVL+7PuNbRe06qlsZuc7Gtwf3J+F0hul37xs2swE75oFUAAAAAAAAAAGDIAGDJgyAAAAAAADIAgY3E/uxJGLraqtvZTSnd37iDE52yWbN4v+JnP6R+JKVKf4cbzl+9q2yfa7+C68CXgtJqa+W3LY10YNVZzrU1+94fcotISTfy7+GRJq04y3Nc16ojOhbbuMZVvHE0XOrrW/ElZbtxZVasv3s/Pv3kLD6QVN5xbW/eSlpChUyTUXweT6Fxs/aZY5fpq6uV1mlt4rmjMMRfPuZpWotfNB58fut6Ik5bZRVv4o9vFFs0w6HR2kNV2ex+7ou0zgoYnenk/D3wOm0Jjtb5Jbd329Swi3ABVAAAAAAAAAABgyYRkAAAAAAyGwRsdUtG2+WXTeFV+Pr367ORzPxlpWWHwzdP9pK0Ydd/ddl5OWtO2702ffuOW+J7VZUo7bzv0WwzldRePHeSu+E9BS1deo2283f7bjsKOj4JLLMxgqSjFJE+mjjMrXqskeH/AI/U0WG49xPsatFrM0gywkeBDxejE9hcNHjURG9uYqV5UXtfV5cr7uZIeIU468eUl2b8iVpDCqSzRzkaro1VF/TLL0X2/wAG5nvquXJx/YlRras3G+W/k/pl6PkWmBxTjJZ7LZ+/eZQ6WjqpT26j+btpyyfc7PqSsLWulxjk+1W29VmdI89j6bhqynFSW/bz3nqUPwzirrVb3XXT9LdzL4pGAZAVgABAAAAABgyYMgAEAAAAyVekanzN/wAK8y0KDSNWyk3xb6L9EwVChU+WpLgml0VvNsoIyUsRBfwwv35ehaOdsK29/rK5Q6EqqWJqtvKMYrxZy5PHbh926yiSYMr6WNpN2U4vsuiwpNPeYxjtXpcw2bWMGmWkmeU2e11vIWN0jSpq85JdSLGtU5L4no/I5LbHNE7FfGOEX/svyK7FaXo4mElTld708mZsrUrejWVWlCT2SjaXk+5kXRk3Gye75H/K7Rb98SP8Pyf4U6b2xk2uT/VHrKVqkl/HFT67H4naXc28uU1dOw+HK+rNLg/DY/NnbnzrRVXOMuj8vfI+hUZXinxSNRiNwAVWAAEAAAAAAAAEAABkwZA1qPJ8jk9P1bUpd3V5fc6jGStBnG/FE/lS4yXhJP7kp9aaRywi/l+588pUa9WU4UclOznK9sruyPoul4f6Vcl5HDRxjw8KjvbJZ8LXOWfsd+HxExnw9+HnLExjLhJvzueuiqmJg70q2ul/DO67mzkFVxmIVSvSbShnr2vN/wDG+yNuBK0JQxMq0acKrm7xtr05Rb+VuVpbtW1s732nT+FP7Jt9j0JpKc4/mfUtpZ/jnK6FjVsm87Ozvk78HwZ1dPD3jc43e9O3TnvifF1NW1Ju74M4LHYKUpf6itt2RV5PojttK0pym0v0XazitOaBrVKcqtOUtRSSnGFlUnDO8nLNqOyytsu3fd0wlqZ2Sba0cJgYP811L8ZRcV9iyxPw/QnFVMPK0lmmnw4o4fBfDMqilON6ajTblPWThr3ySfC18r9S8+CcFib52dPZdPbbdbdmazx63tzwz3daX+hW41GnvTvzTuWGIp/RK2yUo9JbPIizp6leN+KXfkWVeHyy5J923wuc+O9M8s7e+iau7o/fKz7z6NoqetSiz5XRqas9ZbJLPms15tH0b4YxOtTtwfmbnrlVyADYwAAgAAAAAAAAAABkwZComkpfKlxa+5xvxG7ygufkzrtKS+lc34HH6azqQ97v1M0nqyx8L0UuRzmicMnVmrXWfmdPjP2S6HOaJqWxFRdpz5HfgR4fDlWnUlOm7KTu1ZNPJ3unxv4InaI0A6cnJQirpJtRUX27OPDJZHSU2ezEyutbdLrfiDHDRirRSXGytcmRygeM552PaovksZ+iojTTfPxNsZolVItJ2vttl5bDEKqTsWlLYMat6cxP4QU5XnJ7b7W1e2rkm+GRZYXQ9KirQXUuGQMRVNW79SbtcR8RrVmn2rzJuGqqajLc/KX6lH8cY1Qze67NfgvHfiUXG+avbk23Hx1kTCaY5U6acel/6X+vgdX8IY9RnFX+WSS6PZ9jnZ2c89jz9H5knQkHG63wb/6t3/U3XH4+pmSNo+vr04y7CSdGWAAEAAAAAAAAAAAMmDIFXpV5/wAvqclpSX5q6+SOp0q/mfI5TSf7WL5+RnJYvaqvS6I4mFbUx8lulFPuk16ncQzp84nDaahq4qnPipL+2S/+u458jrxXt2lCRJ1siswlW8UTKczlK9OUeNTERg7zdrvK+wl1MZDV2nni8NGpGzKjFYCUclrWNxncrRYyk3JJrWvsvmi6wsvlRU4XRsYu729pZKrZWJrRbt61amRVYmrtPerVKvGTyM2tSPnH/wCk1LyhHfK7XT/J5fCFZ06kEtjTT6Zp+A+MYurioRWyEM+c3s/pv3G+gqNq3JeqR2x8efL8q7TErNW45cpIstFftWnsaz5NWfqVid6cG+T67PEudAwUqsE96s+sWiuddR8M1HquL2rzTsy8Oe0Emqsovbnf18joDc8ZAAVAAAAAAAAAAADJgMCk0o85HL6S+uPvcdHpSX1e9zOaxzvNdPI55Liv8G/y48reLRyPxZTslJbYtNdG143S6nVYCf5a5eTv6lN8UYe8JcpLwbXikMo1jWdCYpTppospTtmj59oDS/4MtWb+SW/dF9vYd3QlfNHn1qvXMtxT6V01ileNHDzlbepU1fk5SRGjpTGRgnKNRN2vHOTjftSfgXmLwzfzRvcjTxtVK1n3e+B1xv8Aj1cdw17pULHY2Lv+G3HjOaz6PMscDiq01rVIKK4KV3z2ZGXGpUa1k7LPsJcIWWZMqxy3D562qVFYqtKYlQi5SdkldkzEVEjififGSqtU4bL/APZpN93qYk3XC3UVeEvWqTqtbW36dyVl3l5oTBZylb3m/Q89HYRRjqrcs+fvzOh0FQ+WT5+SX3O+nl2zCl+VGPFZc836E7QNb54S7VfvI+k4aig1sUl3ZjRklGtq7m7rqRK7XBZYh9qfqXRR6MV5qW9WT5tMvDpGIAAoAAAAAAAAAAAa1HkbHhjZ2iBz+k5/U+1nOYyp+ai6x0/fVHOV3epy/Q5ZNYul0XK8bf8AJd55aap3pyss7XXNGmi6lnya8sydiI3TXNG/iT18i1E6sqfOy429+Jb6A0xPDv8ACqXlBfS98V6o8NKaMn+N+JTX0S+ZLhaxIxmFXyzWySOWcejjrvcDiozSaaaZN/EhY4HATnD6Xbit3cXtDGSazXmSOlxX1SrCxUY3ELcaTrSa2EOtFsWbJEHGTbTOeVJfiR5s6epRuiuw+j5SqtRT2ZvcuvEuM7iZ/jW+HoWg3xy6Wz8Ll58P0vy23vz75MhYihqxhBe7v7IudBw/KfVdzZ1eavHTVC9J/wAr/qf3Kig3rp707fb1OkxUbpr/AGr+4pK2HtVlwaTXSKv5GbCO00JLWz4tPuWZdFDoN/S+K8cr+neXxueMAAKAAAAAADBkoAAgwVmlKu732llUdkUOPq3k3wJlehTY6efvmyow1O8r9pZYp7Xvezl/k0pUdVdpybemB+qXPyVi0nK/Wz71+hW4aOqm3vdywpq8fe5/qbjNQMNgVryfaNIaAdRNU7JrNJ7H2dhb4SlvLGjT3nX+Ms0kysu44GGDcXqTi4yW1P3miZh6Vtx2+IwMKsbTjfg965PcUeO0XKita+tDjvXNepxuGnqx5Zl76qpnkqfEnUcNOq7Uo34yeUVzZd4DQcIfNU+eXb9K5LfzYmO1yzmKnwGh5VM38seO9/8AFepYYjBQhHVgrLzfFveXjRDxdO6OuGMjy553JxmlIWqK+xK/i0vGxZ6Hhaku3WfeQtOxveS4JdVK/wBiw0T+yh1XmjF9X43qR/t8miHKnea528Cxks/5fVEVrNvti/JMiJ/w620o/wALfdn76HRHOYHEKnKSclG7LalJPPWv1ubxnTO00HnE3LpWQAQAABgGQUA2YZ5Ymsoq/ciDwx2IsuhRzV1d7836Hvi25SSeTe3sRrW4L32HLKrFdGjrSu9iz67l0RvKlclqNl5lTpXGNt0aTz/ffC+7mzN6aFV15qMc1s5v7bSywlOUVJTVnfwZGwGG1NXV3b+RZ1qUtSU3vsl74G+PtnJKwUcr9xOUSFo6DilfYTzvWHpATeVuPkax7TeKMtNaMUkoxSSWxLZY2MtGAMNEbEK5JkRcRO2S+p+C4ssSuY0lRtKUXsl4O2Rvof8AZpPap25XLPSNOEVZ7eO+73lPgW4ucXucX42Zz5Oq1j4sms1ya9fQ8KtPau7vPepu5v34kerUs2+Cv6+hjYzOcLrXdtZKzey9tl+hOw1LV+nYVGlqClSWdrStfhd5N9hJ0BKX7Od1JbnmpLijrjn8ZsdDSZ6o8Iwa7UesZm6kb3MpmEjYy0yAABkwjIGGyNKN3d9CRI8quwCjryes5Pa9i7DznPVV3t93fYbYmqk3LpFFZWq3u5O6Wb7XuS7N5wvqtcfj3FWX1NOy4LiyPoqkkk97+ZvjJ+/Ah04ucZ1ZX+aSS4aqva3ZtLLBrZ2LWfmjFVf6Lw2tm9l2u4n4yn8r6eZW6CxyT/Cks7XT3dt+29y3xOaserCakYqPQyyJNLg+hHjtJaRqpGl7ySWxbeZJPKlCx63M1oZ5t2PRmgg1qz1Vcj0Y73te03rQMwRUVml6DlexT1I2advqi0+ma/tOqqxu2UGlFZ8mn78TPJ4Y+vN1LpPjZ9TwnU+a+5oxJ5LsuvG6PCEss9z+/wBzztplJa0ZQe9NdY/dWJ2h4a0UpfXDJPfYqcLVtLx6rJ+hfYKna0lyfLcdcGatafib6oiZOgxYwbBgagyAMoGFK+wyBhkTHVLRJbKDTuI/dXP7Et1BV4mq5PLkuRUaRr3l+FF5RspP/dLb/T5lrH5Vfsy8/I5zDNyvP+Kc2u/VT7mcK0n0r6kYp7Xfo3/gt8DHWb7vfSxX0Y5xtut77kW+Ahb30LjN2M1fYGgkskb1pZeQp5RVzylRbetfp9j1RltFZkqJ4QWZIRKsbRMtCJkwrDNDeRoUaSMoMwyo8sXKSXyJN9uw5nGU6iUvxM23fLZtyOqnsKfSkMhlN41PqmU7xvxs/R+h5NfUhh3k471l0d7eRmLzT4q3U81dGFKzT7fB5P7nSaIneNvfvYc5Vjl1aLPQtfNX3+dv8m8L2zXTUthuecD0OoAAAAAP/9k=');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `escolas`
--
ALTER TABLE `escolas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `escolas`
--
ALTER TABLE `escolas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
