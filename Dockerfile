FROM ubuntu:18.04

# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
# RUN echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update && apt-get upgrade -y --no-install-recommends
# RUN apt-get install -y -qq \
#   mongodb-org-tools \
#   python3-pip
RUN  apt-get install -y -qq \
openslide-tools \
curl \
bzip2 \
git \
build-essential \
tree \
emacs-nox


RUN curl -LO https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
RUN bash Anaconda3-2020.07-Linux-x86_64.sh -p /miniconda -b
RUN rm Anaconda3-2020.07-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN echo "a"
RUN conda update -y conda
RUN conda update -y anaconda


RUN git clone https://github.com/mahmoodlab/CLAM.git
WORKDIR /CLAM
ADD ./docs docs
RUN conda env create -n clam -f docs/clam.yaml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "clam", "/bin/bash", "-c"]


RUN git clone https://github.com/oval-group/smooth-topk.git
WORKDIR /CLAM/smooth-topk
RUN python setup.py install 
RUN pip install xxhash
WORKDIR /CLAM

ENV CONDA_SHLVL=2
ENV CONDA_EXE=/miniconda/bin/conda
ENV CONDA_PREFIX=/miniconda/envs/clam

ENV CONDA_PREFIX_1=/miniconda


ENV CONDA_PYTHON_EXE=/miniconda/bin/python

ENV CONDA_PROMPT_MODIFIER=(clam)

ENV CONDA_ROOT=/miniconda

ENV PATH=/miniconda/envs/clam/bin:/miniconda/condabin:/miniconda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CONDA_DEFAULT_ENV=clam

#ENTRYPOINT ["conda", "run", "-n", "clam", "env"]

#
#RUN source  /root/.bashrc
# ### JUPITER/IRUBY
# RUN pip3 install ipython\
  # openslide-python\
#   h5py\
#   jupyter
# #dsub

# # sinatra port
# EXPOSE 8345
# # synapse port
# EXPOSE 8886

# ### mount point for images
# RUN mkdir /slidepath
# RUN mkdir -p /data

# COPY ./ /ngs/NgsReporter

# # JUPYTER
# WORKDIR /ngs/NgsReporter
# COPY ./jupyter_notebook_config.py /ngs/.jupyter/jupyter_notebook_config.py

# ## REPORTER
# WORKDIR /ngs/NgsReporter

# VOLUME ["/ngs/.config"]

# RUN bundle install --jobs 20 --retry 5
# RUN BUNDLE_GEMFILE=./Gemfile && export BUNDLE_GEMFILE && bundle update

# RUN useradd -m ngsuser
# RUN chown -R ngsuser: /ngs
# RUN chown -R ngsuser: /data
# USER ngsuser

# ENTRYPOINT [ "./docker-entrypoint.sh"]