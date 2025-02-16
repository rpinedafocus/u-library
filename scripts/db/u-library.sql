PGDMP         !            
    y            library    14.0    14.0 B    u           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            v           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            w           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            x           1262    16553    library    DATABASE     k   CREATE DATABASE library WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE library;
                postgres    false                        2615    16554 
   university    SCHEMA        CREATE SCHEMA university;
    DROP SCHEMA university;
                postgres    false                       1255    16831    countdownbooksfunction()    FUNCTION     �  CREATE FUNCTION university.countdownbooksfunction() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW."is_booking"
	THEN
		UPDATE university."books"
		SET total_available = total_available - 1,
			booking_number = booking_number + 1
		WHERE
			id = NEW."book_id";	
	ELSE 
		UPDATE university."books"
		SET total_available = total_available - 1,
			rented_number = rented_number + 1
		WHERE
			id = NEW."book_id";
	END IF;	
RETURN OLD;
END;
$$;
 3   DROP FUNCTION university.countdownbooksfunction();
    
   university          postgres    false    5                       1255    16836    countupbooksfunction()    FUNCTION     �  CREATE FUNCTION university.countupbooksfunction() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF OLD."is_booking"
	THEN
		UPDATE university."books"
		SET total_available = total_available + 1,
			booking_number = booking_number - 1
		WHERE
			id = OLD."book_id";	
	ELSE 
		UPDATE university."books"
		SET total_available = total_available + 1,
			rented_number = rented_number - 1
		WHERE
			id = OLD."book_id";
	END IF;	
RETURN OLD;
END;
$$;
 1   DROP FUNCTION university.countupbooksfunction();
    
   university          postgres    false    5            �            1259    16841    access_roles    TABLE     �  CREATE TABLE university.access_roles (
    id character varying(36) NOT NULL,
    access_role_id integer NOT NULL,
    endpoint character varying(125) NOT NULL,
    role_id integer NOT NULL,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying
);
 $   DROP TABLE university.access_roles;
    
   university         heap    postgres    false    5            y           0    0    TABLE access_roles    COMMENT     <   COMMENT ON TABLE university.access_roles IS 'ACCESS_ROLES';
       
   university          postgres    false    223            �            1259    16840    access_roles_access_role_id_seq    SEQUENCE     �   ALTER TABLE university.access_roles ALTER COLUMN access_role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME university.access_roles_access_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
         
   university          postgres    false    5    223            �            1259    16785    authors    TABLE     �  CREATE TABLE university.authors (
    id character varying(36) NOT NULL,
    author_id integer NOT NULL,
    name character varying(80) NOT NULL,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying
);
    DROP TABLE university.authors;
    
   university         heap    postgres    false    5            z           0    0    TABLE authors    COMMENT     2   COMMENT ON TABLE university.authors IS 'Authors';
       
   university          postgres    false    219            �            1259    16784    authors_author_id_seq    SEQUENCE     �   ALTER TABLE university.authors ALTER COLUMN author_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME university.authors_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
         
   university          postgres    false    5    219            �            1259    16897    booking_rent    TABLE     �  CREATE TABLE university.booking_rent (
    id character varying(36) NOT NULL,
    book_id character varying(36) NOT NULL,
    process_by character varying(36) NOT NULL,
    process_date date,
    return_date date,
    is_booking boolean,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    is_deleted character varying(1) DEFAULT 'N'::character varying
);
 $   DROP TABLE university.booking_rent;
    
   university         heap    postgres    false    5            {           0    0    TABLE booking_rent    COMMENT     <   COMMENT ON TABLE university.booking_rent IS 'Booking_Rent';
       
   university          postgres    false    224            �            1259    16813    booking_rent_old    TABLE     /  CREATE TABLE university.booking_rent_old (
    id character varying(36) NOT NULL,
    book_id character varying(36) NOT NULL,
    booking_rent_by character varying(36) NOT NULL,
    booking_date date,
    rent_date date,
    return_date date,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    returned boolean DEFAULT false
);
 (   DROP TABLE university.booking_rent_old;
    
   university         heap    postgres    false    5            |           0    0    TABLE booking_rent_old    COMMENT     @   COMMENT ON TABLE university.booking_rent_old IS 'Booking_Rent';
       
   university          postgres    false    221            �            1259    16794    books    TABLE     Y  CREATE TABLE university.books (
    id character varying(36) NOT NULL,
    title character varying(80) NOT NULL,
    author_id integer NOT NULL,
    genre_id integer NOT NULL,
    publish_date date,
    rented_number integer DEFAULT 0 NOT NULL,
    booking_number integer DEFAULT 0 NOT NULL,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    total_available integer
);
    DROP TABLE university.books;
    
   university         heap    postgres    false    5            }           0    0    TABLE books    COMMENT     .   COMMENT ON TABLE university.books IS 'Books';
       
   university          postgres    false    220            �            1259    16775    genres    TABLE     �  CREATE TABLE university.genres (
    id character varying(36) NOT NULL,
    genre_id integer NOT NULL,
    name character varying(50) NOT NULL,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying
);
    DROP TABLE university.genres;
    
   university         heap    postgres    false    5            ~           0    0    TABLE genres    COMMENT     0   COMMENT ON TABLE university.genres IS 'Genres';
       
   university          postgres    false    217            �            1259    16774    genres_genre_id_seq    SEQUENCE     �   ALTER TABLE university.genres ALTER COLUMN genre_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME university.genres_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
         
   university          postgres    false    217    5            �            1259    16565    role_seq    SEQUENCE     u   CREATE SEQUENCE university.role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE university.role_seq;
    
   university          postgres    false    5            �            1259    16555    roles    TABLE     �  CREATE TABLE university.roles (
    id character varying(36) NOT NULL,
    role_id integer NOT NULL,
    name character varying(15) NOT NULL,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying
);
    DROP TABLE university.roles;
    
   university         heap    postgres    false    5                       0    0    TABLE roles    COMMENT     .   COMMENT ON TABLE university.roles IS 'Roles';
       
   university          postgres    false    211            �            1259    16743    roles_rol_id_seq    SEQUENCE     �   CREATE SEQUENCE university.roles_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE university.roles_rol_id_seq;
    
   university          postgres    false    5    211            �           0    0    roles_rol_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE university.roles_rol_id_seq OWNED BY university.roles.role_id;
       
   university          postgres    false    214            �            1259    16760    roles_rol_id_seq1    SEQUENCE     �   ALTER TABLE university.roles ALTER COLUMN role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME university.roles_rol_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
         
   university          postgres    false    211    5            �            1259    16560    users    TABLE     W  CREATE TABLE university.users (
    id character varying(36) NOT NULL,
    user_name character varying(10) NOT NULL,
    pwd character varying(72) NOT NULL,
    first_name character varying(25) NOT NULL,
    last_name character varying(25) NOT NULL,
    email character varying(25) NOT NULL,
    role integer NOT NULL,
    created_by character varying(10),
    updated_by character varying(10),
    deleted_by character varying(10),
    created_at date,
    updated_at date,
    deleted_at date,
    active boolean DEFAULT true,
    is_deleted character varying(1) DEFAULT 'N'::character varying
);
    DROP TABLE university.users;
    
   university         heap    postgres    false    5            q          0    16841    access_roles 
   TABLE DATA           �   COPY university.access_roles (id, access_role_id, endpoint, role_id, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted) FROM stdin;
 
   university          postgres    false    223   �[       m          0    16785    authors 
   TABLE DATA           �   COPY university.authors (id, author_id, name, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted) FROM stdin;
 
   university          postgres    false    219   6^       r          0    16897    booking_rent 
   TABLE DATA           �   COPY university.booking_rent (id, book_id, process_by, process_date, return_date, is_booking, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, is_deleted) FROM stdin;
 
   university          postgres    false    224   �_       o          0    16813    booking_rent_old 
   TABLE DATA           �   COPY university.booking_rent_old (id, book_id, booking_rent_by, booking_date, rent_date, return_date, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted, returned) FROM stdin;
 
   university          postgres    false    221   ya       n          0    16794    books 
   TABLE DATA           �   COPY university.books (id, title, author_id, genre_id, publish_date, rented_number, booking_number, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted, total_available) FROM stdin;
 
   university          postgres    false    220   ib       k          0    16775    genres 
   TABLE DATA           �   COPY university.genres (id, genre_id, name, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted) FROM stdin;
 
   university          postgres    false    217   �d       e          0    16555    roles 
   TABLE DATA           �   COPY university.roles (id, role_id, name, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted) FROM stdin;
 
   university          postgres    false    211   f       f          0    16560    users 
   TABLE DATA           �   COPY university.users (id, user_name, pwd, first_name, last_name, email, role, created_by, updated_by, deleted_by, created_at, updated_at, deleted_at, active, is_deleted) FROM stdin;
 
   university          postgres    false    212   �f       �           0    0    access_roles_access_role_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('university.access_roles_access_role_id_seq', 24, true);
       
   university          postgres    false    222            �           0    0    authors_author_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('university.authors_author_id_seq', 10, true);
       
   university          postgres    false    218            �           0    0    genres_genre_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('university.genres_genre_id_seq', 9, true);
       
   university          postgres    false    216            �           0    0    role_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('university.role_seq', 1, false);
       
   university          postgres    false    213            �           0    0    roles_rol_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('university.roles_rol_id_seq', 7, true);
       
   university          postgres    false    214            �           0    0    roles_rol_id_seq1    SEQUENCE SET     C   SELECT pg_catalog.setval('university.roles_rol_id_seq1', 7, true);
       
   university          postgres    false    215            �           2606    16847    access_roles access_role_ipk 
   CONSTRAINT     ^   ALTER TABLE ONLY university.access_roles
    ADD CONSTRAINT access_role_ipk PRIMARY KEY (id);
 J   ALTER TABLE ONLY university.access_roles DROP CONSTRAINT access_role_ipk;
    
   university            postgres    false    223            �           2606    16793    authors author_id_unique 
   CONSTRAINT     \   ALTER TABLE ONLY university.authors
    ADD CONSTRAINT author_id_unique UNIQUE (author_id);
 F   ALTER TABLE ONLY university.authors DROP CONSTRAINT author_id_unique;
    
   university            postgres    false    219            �           2606    16783    genres genre_id_unique 
   CONSTRAINT     Y   ALTER TABLE ONLY university.genres
    ADD CONSTRAINT genre_id_unique UNIQUE (genre_id);
 D   ALTER TABLE ONLY university.genres DROP CONSTRAINT genre_id_unique;
    
   university            postgres    false    217            �           2606    16791    authors id_author_pk 
   CONSTRAINT     V   ALTER TABLE ONLY university.authors
    ADD CONSTRAINT id_author_pk PRIMARY KEY (id);
 B   ALTER TABLE ONLY university.authors DROP CONSTRAINT id_author_pk;
    
   university            postgres    false    219            �           2606    16902    booking_rent id_bking_rent_pk 
   CONSTRAINT     _   ALTER TABLE ONLY university.booking_rent
    ADD CONSTRAINT id_bking_rent_pk PRIMARY KEY (id);
 K   ALTER TABLE ONLY university.booking_rent DROP CONSTRAINT id_bking_rent_pk;
    
   university            postgres    false    224            �           2606    16800    books id_book_pk 
   CONSTRAINT     R   ALTER TABLE ONLY university.books
    ADD CONSTRAINT id_book_pk PRIMARY KEY (id);
 >   ALTER TABLE ONLY university.books DROP CONSTRAINT id_book_pk;
    
   university            postgres    false    220            �           2606    16819 #   booking_rent_old id_booking_rent_pk 
   CONSTRAINT     e   ALTER TABLE ONLY university.booking_rent_old
    ADD CONSTRAINT id_booking_rent_pk PRIMARY KEY (id);
 Q   ALTER TABLE ONLY university.booking_rent_old DROP CONSTRAINT id_booking_rent_pk;
    
   university            postgres    false    221            �           2606    16781    genres id_genre_pk 
   CONSTRAINT     T   ALTER TABLE ONLY university.genres
    ADD CONSTRAINT id_genre_pk PRIMARY KEY (id);
 @   ALTER TABLE ONLY university.genres DROP CONSTRAINT id_genre_pk;
    
   university            postgres    false    217            �           2606    16749    roles id_pk 
   CONSTRAINT     M   ALTER TABLE ONLY university.roles
    ADD CONSTRAINT id_pk PRIMARY KEY (id);
 9   ALTER TABLE ONLY university.roles DROP CONSTRAINT id_pk;
    
   university            postgres    false    211            �           2606    16762    roles rol_id_unique 
   CONSTRAINT     U   ALTER TABLE ONLY university.roles
    ADD CONSTRAINT rol_id_unique UNIQUE (role_id);
 A   ALTER TABLE ONLY university.roles DROP CONSTRAINT rol_id_unique;
    
   university            postgres    false    211            �           2606    16839    users user_unique 
   CONSTRAINT     U   ALTER TABLE ONLY university.users
    ADD CONSTRAINT user_unique UNIQUE (user_name);
 ?   ALTER TABLE ONLY university.users DROP CONSTRAINT user_unique;
    
   university            postgres    false    212            �           2606    16720    users users_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY university.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY university.users DROP CONSTRAINT users_pkey;
    
   university            postgres    false    212            �           2620    16913    booking_rent countdownbookstrgg    TRIGGER     �   CREATE TRIGGER countdownbookstrgg AFTER INSERT ON university.booking_rent FOR EACH ROW EXECUTE FUNCTION university.countdownbooksfunction();
 <   DROP TRIGGER countdownbookstrgg ON university.booking_rent;
    
   university          postgres    false    264    224            �           2620    16834 #   booking_rent_old countdownbookstrgg    TRIGGER     �   CREATE TRIGGER countdownbookstrgg AFTER INSERT ON university.booking_rent_old FOR EACH ROW EXECUTE FUNCTION university.countdownbooksfunction();
 @   DROP TRIGGER countdownbookstrgg ON university.booking_rent_old;
    
   university          postgres    false    221    264            �           2620    16914    booking_rent countupbookstrgg    TRIGGER     �   CREATE TRIGGER countupbookstrgg AFTER UPDATE ON university.booking_rent FOR EACH ROW EXECUTE FUNCTION university.countupbooksfunction();
 :   DROP TRIGGER countupbookstrgg ON university.booking_rent;
    
   university          postgres    false    273    224            �           2620    16837 !   booking_rent_old countupbookstrgg    TRIGGER     �   CREATE TRIGGER countupbookstrgg AFTER UPDATE ON university.booking_rent_old FOR EACH ROW EXECUTE FUNCTION university.countupbooksfunction();
 >   DROP TRIGGER countupbookstrgg ON university.booking_rent_old;
    
   university          postgres    false    221    273            �           2606    16903    booking_rent bkingr_book_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.booking_rent
    ADD CONSTRAINT bkingr_book_id_fk FOREIGN KEY (book_id) REFERENCES university.books(id);
 L   ALTER TABLE ONLY university.booking_rent DROP CONSTRAINT bkingr_book_id_fk;
    
   university          postgres    false    220    3272    224            �           2606    16908    booking_rent bkingr_user_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.booking_rent
    ADD CONSTRAINT bkingr_user_id_fk FOREIGN KEY (process_by) REFERENCES university.users(id);
 L   ALTER TABLE ONLY university.booking_rent DROP CONSTRAINT bkingr_user_id_fk;
    
   university          postgres    false    3262    212    224            �           2606    16801    books book_author_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.books
    ADD CONSTRAINT book_author_id_fk FOREIGN KEY (author_id) REFERENCES university.authors(author_id);
 E   ALTER TABLE ONLY university.books DROP CONSTRAINT book_author_id_fk;
    
   university          postgres    false    220    219    3268            �           2606    16806    books book_genre_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.books
    ADD CONSTRAINT book_genre_id_fk FOREIGN KEY (genre_id) REFERENCES university.genres(genre_id);
 D   ALTER TABLE ONLY university.books DROP CONSTRAINT book_genre_id_fk;
    
   university          postgres    false    3264    220    217            �           2606    16820 $   booking_rent_old bookingr_book_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.booking_rent_old
    ADD CONSTRAINT bookingr_book_id_fk FOREIGN KEY (book_id) REFERENCES university.books(id);
 R   ALTER TABLE ONLY university.booking_rent_old DROP CONSTRAINT bookingr_book_id_fk;
    
   university          postgres    false    221    220    3272            �           2606    16825 $   booking_rent_old bookingr_user_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.booking_rent_old
    ADD CONSTRAINT bookingr_user_id_fk FOREIGN KEY (booking_rent_by) REFERENCES university.users(id);
 R   ALTER TABLE ONLY university.booking_rent_old DROP CONSTRAINT bookingr_user_id_fk;
    
   university          postgres    false    221    3262    212            �           2606    16763    users role_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY university.users
    ADD CONSTRAINT role_id_fk FOREIGN KEY (role) REFERENCES university.roles(role_id) NOT VALID;
 >   ALTER TABLE ONLY university.users DROP CONSTRAINT role_id_fk;
    
   university          postgres    false    212    3258    211            q   M  x���Kn�0E��^�'R$EvYA&E�E��x�Aw_�M� ����0���{�U[���)��7$`a��1A:<n����vN�w/f�[ȷX^���ͨ���6�M��J�ZM�Cs�����h����jC�� ���/>��י(��c\��0��(�0��m�Jm��h �RI��)�W ]�V�In�'�r�&y�I�c�t����g}�����V�m.ɞ�u��i&M��m?�w0q���ٴ��0g��L��	��1�~{�<�e�����(�2y���w@+��J�mV�� ��A1�	V��|���ut��s!�ֆ�ĺԤx^ü��mWɒ1��7�uh�6���	V��==mχ�_�݃��hk�H�Qo-x�WYh�\o��-{��H>{^�S�\�j蜠��	�3v�^�q�%�����6�m����i�+ƵC6֧�:�\*��.�.=c�*�[N���??���|Ems�*��=��6��Z|F��Ξ ����M��[�m0!Xǥ��� �%~b�1�)�Fy
�L�*�������pI�5�=0Sw.9Sq"��%Z�L�Dd�Z��v|�������!ޣ�      m   �  x���Mn1��5��$���ry))�Q,�)�4Ӛ�== �G�b8�}K^�����YkCLUk�Nq��V$�%Eϧi���v���^���kn��68*�$V2zI�(j䂣�\�)u�:<���.�=e�ő͉J�h؋�DO@p����x;|l���HJ�kr"I\!�bsL9b-�08x��<��Y�i;M�Ģђ�βFǆ��u�ٻ%���y��C�e�M2��b�G�69[K��S#��۩w���j&�9ϻ�ԧ��C�*��8r�~��޷�t��Iwsn۶���gR2����s�!o
g��N~�������~�����5��7F�h�.+��H�<����w�t��k��۵�ڷ_����'6.������Y�q��ni�����^n��_��:      r   �  x���Kn1D�=w���H��Ĝ��"�,�E>�mǱ �L0;����TU�Y�W\�MR]�g�^D� �{H��D�`U��������-C���4@��d�8:�vnp��u�#����ۡ���������X��i�ބ.���J.���u0�S:��!�v[�Hf҂l������OS�S1�e�tͼld��d|���/Y���W�[ۣN�;���;�����9tg��;'��M����w$W�v��:H;�4Ҝ����=��- K0Z�5��'S����}=d��J�.�+r]
$�(n��\�c�[Y���X�{���Xi�\���d����mW�"wtm���3�+�}z�	��jT��X�Ȏ���K�� _$���������t�m"B      o   �   x���1NDA�z�]�0p	O�<��B]��[�1���P���rR.NSA�|8��=�#s̆U3�I�r���z�:�toT��|��D_Ulɨ��~�p�����V���+������&J텞=��V�0��}dk�z�N�c���b_��꾼�M�DLx�l��4s����\5z�l�3Q�
�$`P7��a�O�Uw�O������w�z��۶} 0u&      n     x���Mj�@F׭S����zm�16&�,���F#��[��Xz;�C��Z	���}-h�,h�蕕j��.H�5s1�v�_?��(:
�!c�V�}�e�����8,�V�?=8�;�F���VrI��/��B��u������������������0���9Qv�r�b_@0�8Ґ��� ��%�K�5�5�}��ͼ�77��,�B�!��	��V��:烙͇R5x(r��Vt^�˲%{��@�����[��PU�D(6�L��}DN��()x*^"SEM�'�ͭ�v=^-�-x�/m�!���d95/I8�Ԏ�P����ˍ�'�h��b,*1�蹯��eWXf�������[�>���C�MQ� 2y��U4��Rh����Ms'>����i�<��Ⱦ';�ĹԊ(�j�f[�^c�Yʋ�{��2g_���)a
���Bq%q+��%r��Eg>J��6k�u�`���wf`�f]��$���s�~2��^t^PH�r3N2-�c+������0��.1�      k   q  x��ҽ�1�����b�<W���8���;A3�J����$����r<r��$,N�)Y��2^�JH�y�y�������E������S��E1�B�kɘ��Z+��'ݵ��M'^d�z�v]���b�I5O.��b�H�<a᥯k_��@�r�ZZp��D����Y� �˼�}�+_��yd�˱3�V��Sq�Xd��J`����S��u������������oz9慘|#A[\�m��l�2"k�߃�/�Qn��?W=t�anN�ӡ�[� & Ƅ���<>����B��0��6��L"�(?��d��o�\�C���ld�
�j�\c�b�H�� ���8ι�u^���_�������Ȓ      e   �   x���;�0 �z}
.�]�/%H���ر-Q@P�GH� M5�#����(S�>ה������z��p����u�a�>Q$0�߱����kg��rk%u"��#�h�AX��S��!��G��`#Β\�m�����,�8K      f   9  x���Ao�0��3|�b[���.�(F&ʂ�K�-�@q��~5q��i~���<M�דN�/���;�S�ɢE�XN47��xK����
�^3��;��e��l<�7�j����m�?ݦ��c�������ׯ���� B&#�kB��	d��	L � �(���Sd���	LH��z�\W��E�~%̉���'MR.�F���a��wӠ�o��&�qN<$�EQ=P ؅����ƉA 	�B3)	��8�M��h�O$�7�S%�����cn�z�;f�tfﮘU��x�g�n�qe�hu>2|G��慨�K�*�,�ɖ     